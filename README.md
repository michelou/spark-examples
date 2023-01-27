# <span id="top">Playing with Spark on Windows</span>

<table style="font-family:Helvetica,Arial;font-size:14px;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://spark.apache.org/" rel="external"><img src="https://spark.apache.org/images/spark-logo-trademark.png" width="120" alt="Spark project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://spark.apache.org/" rel="external">Spark</a> code examples coming from various websites and books.<br/>
  It also includes several <a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting" rel="external">batch files</a> for experimenting with <a href="https://spark.apache.org/" rel="external">Spark</a> on the <b>Microsoft Windows</b> platform.
  </td>
  </tr>
</table>

[Ada][ada_examples], [Akka][akka_examples], [C++][cpp_examples], [Dart][dart_examples], [Deno][deno_examples], [Flix][flix_examples], [Golang][golang_examples], [GraalVM][graalvm_examples], [Haskell][haskell_examples], [Kafka][kafka_examples], [Kotlin][kotlin_examples], [LLVM][llvm_examples], [Python][python_examples], [Rust][rust_examples], [Scala 3][scala3_examples], [Spark][spark_examples], [Spring][spring_examples], [TruffleSqueak][trufflesqueak_examples] and [WiX Toolset][wix_examples] are other trending topics we are continuously monitoring.


## <span id="proj_deps">Project dependencies</span>

This project depends on two external software for the **Microsoft Windows** platform:

- [Apache Maven 3.8][apache_maven] ([requires Java 7][apache_maven_history])  ([*release notes*][apache_maven_relnotes])
- [Git 2.39][git_downloads] ([*release notes*][git_relnotes])
- [Oracle OpenJDK 8 LTS][oracle_openjdk8] ([*release notes*][oracle_openjdk8_relnotes])
- [sbt 1.8][sbt_downloads] (requires Java 8) ([*release notes*][sbt_relnotes])
- [Scala 2.13][scala_releases] (requires Java 8) ([*release notes*][scala_relnotes])
- [Spark 3.3][spark_downloads] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][spark_relnotes])

Optionally one may also install the following software:

- [Temurin OpenJDK 11 LTS][temurin_opendjk11] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][temurin_opendjk11_relnotes], [*bug fixes*][temurin_opendjk11_bugfixes])
- [Temurin OpenJDK 17 LTS][temurin_opendjk17] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][temurin_opendjk17_relnotes], [*bug fixes*][temurin_opendjk17_bugfixes])

> **&#9755;** ***Installation policy***<br/>
> When possible we install software from a [Zip archive][zip_archive] rather than via a Windows installer. In our case we defined **`C:\opt\`** as the installation directory for optional software tools (*similar to* the [**`/opt/`**][linux_opt] directory on Unix).

For instance our development environment looks as follows (*January 2023*) <sup id="anchor_02">[2](#footnote_02)</sup>:

<pre style="font-size:80%;">
C:\opt\apache-maven-3.8.7\                 <i>( 10 MB)</i>
C:\opt\Git-2.39.1\                         <i>(314 MB)</i>
C:\opt\jdk-temurin-1.8.0_352-b08\          <i>(185 MB)</i>
C:\opt\jdk-temurin-11.0.18_10\             <i>(302 MB)</i>
C:\opt\jdk-temurin-17.0.6_10\              <i>(299 MB)</i>
C:\opt\sbt-1.8.2\                          <i>(110 MB)</i>
C:\opt\scala-2.13.10\                      <i>( 24 MB)</i>
C:\opt\spark-3.3.1-bin-hadoop3\            <i>(320 MB)</i>
C:\opt\spark-3.3.1-bin-hadoop3-scala2.13\  <I>(327 MB)</i>
</pre>

> **:mag_right:** [Git for Windows](https://git-scm.com/download/win) provides a BASH emulation used to run [**`git`**][git_docs] from the command line (as well as over 250 Unix commands like [**`awk`**][man1_awk], [**`diff`**][man1_diff], [**`file`**][man1_file], [**`grep`**][man1_grep], [**`more`**][man1_more], [**`mv`**][man1_mv], [**`rmdir`**][man1_rmdir], [**`sed`**][man1_sed] and [**`wc`**][man1_wc]).

## <span id="structure">Directory structure</span> [**&#x25B4;**](#top)

This project is organized as follows:
<pre style="font-size:80%;">
bin\
docs\
examples\{<a href="./examples/README.md">README.md</a>, <a href="./examples/HelloWorld/">HelloWorld</a>, etc.}
README.md
<a href="QUICKREF.md">QUICKREF.md</a>
<a href="RESOURCES.md">RESOURCES.md</a>
<a href="setenv.bat">setenv.bat</a>
</pre>

where

- directory [**`bin\`**](bin/) contains utility batch scripts.
- directory [**`docs\`**](docs/) contains [Spark] related papers/articles.
- directory [**`examples`**](examples/) contain [Spark] code examples.
- file **`README.md`** is the [Markdown][github_markdown] document for this page.
- file [**`QUICKREF.md`**](QUICKREF.md) gathers Spark hints and tips.
- file [**`RESOURCES.md`**](RESOURCES.md) is the [Markdown][github_markdown] document presenting external resources.
- file [**`setenv.bat`**](setenv.bat) is the batch script for setting up our environment.

We also define a virtual drive **`K:`** in our working environment in order to reduce/hide the real path of our project directory (see article ["Windows command prompt limitation"][windows_limitation] from Microsoft Support).

> **:mag_right:** We use the Windows external command [**`subst`**][windows_subst] to create virtual drives; for instance:
>
> <pre style="font-size:80%;">
> <b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst">subst</a> K: <a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\workspace\spark-examples</b>
> </pre>

In the next section we give a brief description of the batch files present in this project.


## <span id="commands">Batch/Bash commands</span>

We distinguish different sets of batch/bash commands:

1. [**`setenv.bat`**](setenv.bat) &ndash; This batch command makes external tools such as [**`sbt.bat`**][sbt_cli] directly available from the command prompt (see section [**Project dependencies**](#proj_deps)).

   <pre style="font-size:80%;">
   <b>&gt; <a href="setenv.bat">setenv</a> help</b>
   Usage: setenv { &lt;option&gt; | &lt;subcommand&gt; }
   &nbsp;
     Options:
       -bash       start Git bash shell instead of Windows command prompt
       -debug      show commands executed by this script
       -verbose    display environment settings
   &nbsp;
     Subcommands:
       help        display this help message
   </pre>

## <span id="examples">Usage examples</span> [**&#x25B4;**](#top)

### **`setenv.bat`**

Command [**`setenv.bat`**](setenv.bat) is executed once to setup our development environment; it makes external tools such as [**`sbt.bat`**][sbt_cli] and [**`git.exe`**][git_cli] directly available from the command prompt.

<pre style="font-size:80%;">
<b>&gt; <a href="setenv.bat">setenv</a></b>
Tool versions:
   java 11.0.18, sbt 1.8.2, scalac 2.13.10,
   mvn 3.8.7, git 2.39.1.windows.1, diff 3.8, bash 5.2.12(1)-release

<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1" rel="external">where</a> sbt</b>
C:\opt\sbt-1.8.2\bin\sbt
C:\opt\sbt-1.8.2\bin\sbt.bat
</pre>

## <span id="footnotes">Footnotes</span>

<span id="footnote_01">[1]</span> ***Scala 2.13 Support*** [↩](#anchor_01)

<dl><dd>
Spark 3.2.0 and newer add support for Scala 2.13 (see <a href="https://issues.apache.org/jira/browse/SPARK-34218">PR#34218</a>).
</dd></dl>

<span id="footnote_02">[2]</span> ***Downloads*** [↩](#anchor_02)

<dl><dd>
In our case we downloaded the following installation files (<a href="#proj_deps">see section 1</a>):
</dd>
<dd>
<pre style="font-size:80%;">
<a href="https://maven.apache.org/download.cgi">apache-maven-3.8.7-bin.zip</a>                         <i>( 10 MB)</i>
<a href="https://adoptium.net/releases.html?variant=openjdk8&jvmVariant=hotspot">OpenJDK8U-jdk_x64_windows_hotspot_8u352b08.zip</a>     <i>( 99 MB)</i>
<a href="https://adoptium.net/?variant=openjdk11">OpenJDK11U-jdk_x64_windows_hotspot_11.0.18_10.zip</a>  <i>(194 MB)</i>
<a href="https://adoptium.net/?variant=openjdk17">OpenJDK17U-jdk_x64_windows_hotspot_17.0.6_10.zip</a>   <i>(191 MB)</i>
<a href="https://git-scm.com/download/win">PortableGit-2.39.1-64-bit.7z.exe</a>                   <i>( 41 MB)</i>
<a href="https://github.com/sbt/sbt/releases">sbt-1.8.2.zip</a>                                      <i>( 17 MB)</i>
<a href="https://www.scala-lang.org/files/archive/">scala-2.13.10.zip</a>                                  <i>( 21 MB)</i>
<a href="https://spark.apache.org/downloads.html">spark-3.3.1-bin-hadoop3.2.tgz</a>                      <i>(285 MB)</i>
<a href="https://spark.apache.org/downloads.html">spark-3.3.1-bin-hadoop3-scala2.13.tgz</a>              <i>(292 MB)</i>
</pre>
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/January 2023* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[ada_examples]: https://github.com/michelou/ada-examples
[akka_examples]: https://github.com/michelou/akka-examples
[apache_maven]: https://maven.apache.org/download.cgi
[apache_maven_cli]: https://maven.apache.org/ref/current/maven-embedder/cli.html
[apache_maven_history]: https://maven.apache.org/docs/history.html
[apache_maven_relnotes]: https://maven.apache.org/docs/3.8.7/release-notes.html
[cpp_examples]: https://github.com/michelou/cpp-examples
[dart_examples]: https://github.com/michelou/dart-examples
[deno_examples]: https://github.com/michelou/deno-examples
[flix_examples]: https://github.com/michelou/flix-examples
[git_cli]: https://git-scm.com/docs/git
[git_docs]: https://git-scm.com/docs/git
[git_downloads]: https://git-scm.com/download/win
[github_markdown]: https://github.github.com/gfm/
[git_relnotes]: https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2.39.1.txt
[golang_examples]: https://github.com/michelou/golang-examples
[graalvm_examples]: https://github.com/michelou/graalvm-examples
[hadoop_downloads]: https://hadoop.apache.org/releases.html
[haskell_examples]: https://github.com/michelou/haskell-examples
[kafka_examples]: https://github.com/michelou/kafka-examples
[kotlin_examples]: https://github.com/michelou/kotlin-examples
[linux_opt]: https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/opt.html
[llvm_examples]: https://github.com/michelou/llvm-examples
[man1_awk]: https://www.linux.org/docs/man1/awk.html
[man1_diff]: https://www.linux.org/docs/man1/diff.html
[man1_file]: https://www.linux.org/docs/man1/file.html
[man1_grep]: https://www.linux.org/docs/man1/grep.html
[man1_more]: https://www.linux.org/docs/man1/more.html
[man1_mv]: https://www.linux.org/docs/man1/mv.html
[man1_rmdir]: https://www.linux.org/docs/man1/rmdir.html
[man1_sed]: https://www.linux.org/docs/man1/sed.html
[man1_wc]: https://www.linux.org/docs/man1/wc.html
[oracle_openjdk8]: https://adoptium.net/releases.html?variant=openjdk8&jvmVariant=hotspot
[oracle_openjdk8_relnotes]: https://mail.openjdk.java.net/pipermail/jdk8u-dev/2021-July/014118.html
[python_examples]: https://github.com/michelou/python-examples
[rust_examples]: https://github.com/michelou/rust-examples
[sbt_cli]: https://www.scala-sbt.org/1.x/docs/Command-Line-Reference.html
[sbt_downloads]: https://github.com/sbt/sbt/releases
[sbt_relnotes]: https://github.com/sbt/sbt/releases/tag/v1.8
[scala_releases]: https://www.scala-lang.org/files/archive/
[scala_relnotes]: https://github.com/scala/scala/releases/tag/v2.13.10
[scala3_examples]: https://github.com/michelou/dotty-examples
[spark_examples]: https://github.com/michelou/spark-examples
[spring_examples]: https://github.com/michelou/spring-examples
[spark]: https://spark.apache.org
[spark_downloads]: https://spark.apache.org/downloads.html
[spark_relnotes]: https://spark.apache.org/releases/spark-release-3-3-1.html
[temurin_opendjk11_bugfixes]: https://www.oracle.com/java/technologies/javase/11-0-17-bugfixes.html
[temurin_opendjk11_relnotes]: https://mail.openjdk.org/pipermail/jdk-updates-dev/2022-October/018119.html
[temurin_opendjk11]: https://adoptium.net/releases.html?variant=openjdk11&jvmVariant=hotspot
[temurin_opendjk17]: https://adoptium.net/releases.html?variant=openjdk17&jvmVariant=hotspot
[temurin_opendjk17_bugfixes]: https://www.oracle.com/java/technologies/javase/17-0-2-bugfixes.html
[temurin_opendjk17_relnotes]: https://github.com/openjdk/jdk/compare/jdk-17%2B20...jdk-17%2B21
[trufflesqueak_examples]: https://github.com/michelou/trufflesqueak-examples
[windows_limitation]: https://support.microsoft.com/en-gb/help/830473/command-prompt-cmd-exe-command-line-string-limitation
[windows_subst]: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst
[wix_examples]: https://github.com/michelou/wix-examples
[zip_archive]: https://www.howtogeek.com/178146/
