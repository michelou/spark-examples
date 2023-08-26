# <span id="top">Playing with Spark on Windows</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://spark.apache.org/" rel="external"><img src="https://spark.apache.org/images/spark-logo-trademark.png" width="120" alt="Spark project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://spark.apache.org/" rel="external">Spark</a> code examples coming from various websites and books.<br/>
  It also includes several build scripts (<a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting" rel="external">batch files</a>) for experimenting with <a href="https://spark.apache.org/" rel="external">Spark</a> on a Windows machine.
  </td>
  </tr>
</table>

> **&#9755;** Read the document <a href="https://spark.apache.org">"What is Apache Spark™?"</a> from the <a href="https://spark.apache.org" rel="external">Spark</a> documentation to know more about the <a href="https://spark.apache.org" rel="external">Spark</a> ecosystem.

[Ada][ada_examples], [Akka][akka_examples], [C++][cpp_examples], [Dart][dart_examples], [Deno][deno_examples], [Docker][docker_examples], [Flix][flix_examples], [Golang][golang_examples], [GraalVM][graalvm_examples], [Haskell][haskell_examples], [Kafka][kafka_examples], [Kotlin][kotlin_examples], [LLVM][llvm_examples], [Rust][rust_examples], [Scala 3][scala3_examples], [Spring][spring_examples], [TruffleSqueak][trufflesqueak_examples] and [WiX Toolset][wix_examples] are other trending topics we are continuously monitoring.


## <span id="proj_deps">Project dependencies</span>

This project depends on two external software for the **Microsoft Windows** platform:

- [Apache Maven 3.9][apache_maven] ([requires Java 8+][apache_maven_history])  ([*release notes*][apache_maven_relnotes])
- [Git 2.42][git_downloads] ([*release notes*][git_relnotes])
- [sbt 1.9][sbt_downloads] (requires Java 8) ([*release notes*][sbt_relnotes])
- [Scala 2.13][scala_releases] (requires Java 8) ([*release notes*][scala_relnotes])
- [Spark 3.4][spark_downloads] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][spark_relnotes])
- [Temurin OpenJDK 11 LTS][temurin_openjdk11] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][temurin_openjdk11_relnotes], [*bug fixes*][temurin_openjdk11_bugfixes])

Optionally one may also install the following software:
- [Gradle 8.3][gradle_install] <sup id="anchor_01">[1](#footnote_01)</sup> ([requires Java 8+][gradle_compatibility]) ([*release notes*][gradle_relnotes])
- [Oracle OpenJDK 21 LTS][oracle_openjdk21] ([*release notes*][oracle_openjdk21_relnotes], [*Java 21 API*][oracle_openjdk21_api])
- [Temurin OpenJDK 17 LTS][temurin_openjdk17] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][temurin_openjdk17_relnotes], [*bug fixes*][temurin_openjdk17_bugfixes])

> **&#9755;** ***Installation policy***<br/>
> When possible we install software from a [Zip archive][zip_archive] rather than via a Windows installer. In our case we defined **`C:\opt\`** as the installation directory for optional software tools (*similar to* the [**`/opt/`**][linux_opt] directory on Unix).

For instance our development environment looks as follows (*August 2023*) <sup id="anchor_02">[2](#footnote_02)</sup>:

<pre style="font-size:80%;">
C:\opt\apache-maven-3.9.4\                 <i>( 10 MB)</i>
C:\opt\Git\                                <i>(367 MB)</i>
C:\opt\gradle\                             <i>(135 MB)</i>
C:\opt\jdk-oracle-21-ea-35\                <i>(320 MB)</i>
C:\opt\jdk-temurin-11.0.20_8\              <i>(302 MB)</i>
C:\opt\jdk-temurin-17.0.8_7\               <i>(299 MB)</i>
C:\opt\sbt\                                <i>(135 MB)</i>
C:\opt\scala-2.13.11\                      <i>( 24 MB)</i>
C:\opt\spark-3.4.1-bin-hadoop3\            <i>(320 MB)</i>
C:\opt\spark-3.4.1-bin-hadoop3-scala2.13\  <I>(327 MB)</i>
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
- directory [**`docs\`**](docs/) contains [apache_spark] related papers/articles.
- directory [**`examples`**](examples/) contain [apache_spark] code examples.
- file **`README.md`** is the [Markdown][github_markdown] document for this page.
- file [**`QUICKREF.md`**](QUICKREF.md) gathers Spark hints and tips.
- file [**`RESOURCES.md`**](RESOURCES.md) is the [Markdown][github_markdown] document presenting external resources.
- file [**`setenv.bat`**](setenv.bat) is the batch script for setting up our environment.

We also define a virtual drive &ndash; e.g. drive **`K:`** &ndash; in our working environment in order to reduce/hide the real path of our project directory (see article ["Windows command prompt limitation"][windows_limitation] from Microsoft Support).

> **:mag_right:** We use the Windows external command [**`subst`**][windows_subst] to create virtual drives; for instance:
>
> <pre style="font-size:80%;">
> <b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst">subst</a> K: <a href="https://en.wikipedia.org/wiki/Environment_variable#Default_values">%USERPROFILE%</a>\workspace\spark-examples</b>
> </pre>

In the next section we give a brief description of the batch files present in this project.


## <span id="commands">Batch/Bash commands</span> [**&#x25B4;**](#top)

### **`setenv.bat`** <sup id="anchor_03">[3](#footnote_03)</sup>

Command [**`setenv.bat`**](setenv.bat) is executed once to setup our development environment; it makes external tools such as [**`mvn.cmd`**][apache_maven_cli] and [**`sbt.bat`**][sbt_cli] directly available from the command prompt.

<pre style="font-size:80%;">
<b>&gt; <a href="setenv.bat">setenv</a></b>
Tool versions:
   java 11.0.20, sbt 1.9.3, scalac 2.13.11, spark-shell 3.4.1,
   mvn 3.9.4, git 2.42.0.windows.1, diff 3.10, bash 5.2.12(1)-release

<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1" rel="external">where</a> mvn sbt</b>
C:\opt\apache-maven-3.9.4\bin\mvn
C:\opt\apache-maven-3.9.4\bin\mvn.cmd
C:\opt\sbt\bin\sbt
C:\opt\sbt\bin\sbt.bat
</pre>

<!--=======================================================================-->

## <span id="footnotes">Footnotes</span> [**&#x25B4;**](#top)

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
<a href="https://maven.apache.org/download.cgi">apache-maven-3.9.4-bin.zip</a>                         <i>( 10 MB)</i>
<a href="https://gradle.org/install/">gradle-8.2.1-bin.zip</a>                               <i>(118 MB)</i>
<a href="https://adoptium.net/?variant=openjdk11">OpenJDK11U-jdk_x64_windows_hotspot_11.0.20_8.zip</a>   <i>(194 MB)</i>
<a href="https://adoptium.net/?variant=openjdk17">OpenJDK17U-jdk_x64_windows_hotspot_17.0.8_7.zip</a>    <i>(191 MB)</i>
<a href="https://jdk.java.net/21/">openjdk-21_windows-x64_bin_build_35.zip</a>            <i>(191 MB)</i>
<a href="https://git-scm.com/download/win">PortableGit-2.42.0-64-bit.7z.exe</a>                   <i>( 41 MB)</i>
<a href="https://github.com/sbt/sbt/releases">sbt-1.9.3.zip</a>                                      <i>( 17 MB)</i>
<a href="https://www.scala-lang.org/files/archive/">scala-2.13.11.zip</a>                                  <i>( 21 MB)</i>
<a href="https://spark.apache.org/downloads.html">spark-3.4.1-bin-hadoop3.2.tgz</a>                      <i>(285 MB)</i>
<a href="https://spark.apache.org/downloads.html">spark-3.4.1-bin-hadoop3-scala2.13.tgz</a>              <i>(292 MB)</i>
</pre>
</dd></dl>

<span id="footnote_03">[3]</span> **`setenv.bat` *usage*** [↩](#anchor_03)

<dl><dd>
Batch file <a href=./setenv.bat><code><b>setenv.bat</b></code></a> has specific environment variables set that enable us to use command-line developer tools more easily.
</dd>
<dd>It is similar to the setup scripts described on the page <a href="https://learn.microsoft.com/en-us/visualstudio/ide/reference/command-prompt-powershell" rel="external">"Visual Studio Developer Command Prompt and Developer PowerShell"</a> of the <a href="https://learn.microsoft.com/en-us/visualstudio/windows" rel="external">Visual Studio</a> online documentation.
</dd>
<dd>
For instance we can quickly check that the two scripts <code>Launch-VsDevShell.ps1</code> and <code>VsDevCmd.bat</code> are indeed available in our Visual Studio 2019 installation :
<pre style="font-size:80%;">
<b>&gt; <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/where" rel="external">where</a> /r "C:\Program Files (x86)\Microsoft Visual Studio" *vsdev*</b>
C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\Launch-VsDevShell.ps1
C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\VsDevCmd.bat
C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\vsdevcmd\core\vsdevcmd_end.bat
C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\vsdevcmd\core\vsdevcmd_start.bat
</pre>
</dd>
<dd>
Concretely, in our GitHub projects which depend on Visual Studio (e.g. <a href="https://github.com/michelou/cpp-examples"><code>michelou/cpp-examples</code></a>), <a href="./setenv.bat"><code><b>setenv.bat</b></code></a> do invoke <code><b>VsDevCmd.bat</b></code> (resp. <code>vcvarall.bat</code> for older Visual Studio versions) to setup the Visual Studio tools on the command prompt. 
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/August 2023* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[ada_examples]: https://github.com/michelou/ada-examples
[akka_examples]: https://github.com/michelou/akka-examples
[apache_maven]: https://maven.apache.org/download.cgi
[apache_maven_cli]: https://maven.apache.org/ref/current/maven-embedder/cli.html
[apache_maven_history]: https://maven.apache.org/docs/history.html
[apache_maven_relnotes]: https://maven.apache.org/docs/3.9.4/release-notes.html
[apache_spark]: https://spark.apache.org
[apache_spark_sql]: https://spark.apache.org/docs/latest/sql-programming-guide.html
[cpp_examples]: https://github.com/michelou/cpp-examples
[dart_examples]: https://github.com/michelou/dart-examples
[deno_examples]: https://github.com/michelou/deno-examples
[docker_examples]: https://github.com/michelou/docker-examples
[flix_examples]: https://github.com/michelou/flix-examples
[git_cli]: https://git-scm.com/docs/git
[git_docs]: https://git-scm.com/docs/git
[git_downloads]: https://git-scm.com/download/win
[github_markdown]: https://github.github.com/gfm/
[git_relnotes]: https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2.42.0.txt
[golang_examples]: https://github.com/michelou/golang-examples
[graalvm_examples]: https://github.com/michelou/graalvm-examples
[gradle_cli]: https://docs.gradle.org/current/userguide/command_line_interface.html
[gradle_compatibility]: https://docs.gradle.org/current/release-notes.html#upgrade-instructions
[gradle_install]: https://gradle.org/install/
[gradle_relnotes]: https://docs.gradle.org/8.2/release-notes.html
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
[oracle_openjdk21]: https://jdk.java.net/21/
[oracle_openjdk21_api]: https://download.java.net/java/early_access/jdk21/docs/api/
[oracle_openjdk21_relnotes]: https://jdk.java.net/21/release-notes
[python_examples]: https://github.com/michelou/python-examples
[rust_examples]: https://github.com/michelou/rust-examples
[sbt_cli]: https://www.scala-sbt.org/1.x/docs/Command-Line-Reference.html
[sbt_downloads]: https://github.com/sbt/sbt/releases
[sbt_relnotes]: https://github.com/sbt/sbt/releases/tag/v1.9.3
[scala_releases]: https://www.scala-lang.org/files/archive/
[scala_relnotes]: https://github.com/scala/scala/releases/tag/v2.13.11
[scala3_examples]: https://github.com/michelou/dotty-examples
[spring_examples]: https://github.com/michelou/spring-examples
[spark_downloads]: https://spark.apache.org/downloads.html
<!--
3.3.2 -> https://spark.apache.org/releases/spark-release-3-3-2.html
3.4.1 -> https://spark.apache.org/releases/spark-release-3-4-1.html
-->
[spark_relnotes]: https://spark.apache.org/releases/spark-release-3-4-1.html
[temurin_openjdk8]: https://adoptium.net/releases.html?variant=openjdk8&jvmVariant=hotspot
[temurin_openjdk8_relnotes]: https://mail.openjdk.java.net/pipermail/jdk8u-dev/2022-January/014522.html
<!--
11.0.9  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2020-October/004007.html
11.0.13 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2021-October/009368.html
11.0.16 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2022-July/016017.html
11.0.17 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2022-October/018119.html
11.0.18 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-January/020111.html
11.0.20 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-April/021900.html
11.0.20 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-July/024064.html
-->
[temurin_openjdk11]: https://adoptium.net/releases.html?variant=openjdk11&jvmVariant=hotspot
[temurin_openjdk11_bugfixes]: https://www.oracle.com/java/technologies/javase/11-0-17-bugfixes.html
[temurin_openjdk11_relnotes]: https://mail.openjdk.org/pipermail/jdk-updates-dev/2022-October/018119.html
<!--
17.0.7  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-April/021899.html
17.0.8  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-July/024063.html
-->
[temurin_openjdk17]: https://adoptium.net/releases.html?variant=openjdk17&jvmVariant=hotspot
[temurin_openjdk17_bugfixes]: https://www.oracle.com/java/technologies/javase/17-0-2-bugfixes.html
[temurin_openjdk17_relnotes]: https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-July/024063.html
[trufflesqueak_examples]: https://github.com/michelou/trufflesqueak-examples
[windows_limitation]: https://support.microsoft.com/en-gb/help/830473/command-prompt-cmd-exe-command-line-string-limitation
[windows_subst]: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst
[wix_examples]: https://github.com/michelou/wix-examples
[zip_archive]: https://www.howtogeek.com/178146/
