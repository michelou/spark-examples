# <span id="top">Playing with Spark on Windows</span>

<table style="font-family:Helvetica,Arial;line-height:1.6;">
  <tr>
  <td style="border:0;padding:0 10px 0 0;min-width:120px;"><a href="https://spark.apache.org/" rel="external"><img src="https://spark.apache.org/images/spark-logo-trademark.png" width="120" alt="Spark project"/></a></td>
  <td style="border:0;padding:0;vertical-align:text-top;">This repository gathers <a href="https://spark.apache.org/" rel="external">Spark</a> code examples coming from various websites and books.<br/>
  It also includes several build scripts (<a href="https://cloudblogs.microsoft.com/opensource/2023/02/21/introducing-bash-for-beginners/">Bash scripts</a>, <a href="https://en.wikibooks.org/wiki/Windows_Batch_Scripting" rel="external">batch files</a>, <a href="https://makefiletutorial.com/" rel="external">Make scripts</a>) for experimenting with <a href="https://spark.apache.org/" rel="external">Spark</a> on a Windows machine.
  </td>
  </tr>
</table>

> **&#9755;** Read the document <a href="https://spark.apache.org">"What is Apache Spark™?"</a> from the <a href="https://spark.apache.org" rel="external">Spark</a> documentation to know more about the <a href="https://spark.apache.org" rel="external">Spark</a> ecosystem.

[Ada][ada_examples], [Akka][akka_examples], [C++][cpp_examples], [COBOL][cobol_examples], [Dart][dart_examples], [Deno][deno_examples], [Docker][docker_examples], [Flix][flix_examples], [Golang][golang_examples], [GraalVM][graalvm_examples], [Haskell][haskell_examples], [Kafka][kafka_examples], [Kotlin][kotlin_examples], [LLVM][llvm_examples], [Modula-2][m2_examples], [Node.js][nodejs_examples], [Rust][rust_examples], [Scala 3][scala3_examples], [Spring][spring_examples], [TruffleSqueak][trufflesqueak_examples] and [WiX Toolset][wix_examples] are other trending topics we are continuously monitoring.


## <span id="proj_deps">Project dependencies</span>

This project depends on two external software for the **Microsoft Windows** platform:

- [Apache Maven 3.9][apache_maven] ([requires Java 8+][apache_maven_history])  ([*release notes*][apache_maven_relnotes])
- [Git 2.44][git_downloads] ([*release notes*][git_relnotes])
- [MSYS2 2024][msys2_downloads] ([*changelog*][msys2_changelog])
- [sbt 1.9][sbt_downloads] (requires Java 8) ([*release notes*][sbt_relnotes])
- [Scala 2.13][scala_releases] (requires Java 8) ([*release notes*][scala_relnotes])
- [Spark 3.5][spark_downloads] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][spark_relnotes])
- [Temurin OpenJDK 11 LTS][temurin_openjdk11] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][temurin_openjdk11_relnotes], [*bug fixes*][temurin_openjdk11_bugfixes])

Optionally one may also install the following software:
- [Gradle 8.7][gradle_install] <sup id="anchor_01">[1](#footnote_01)</sup> ([requires Java 8+][gradle_compatibility]) ([*release notes*][gradle_relnotes])
- [Temurin OpenJDK 17 LTS][temurin_openjdk17] <sup id="anchor_01">[1](#footnote_01)</sup> ([*release notes*][temurin_openjdk17_relnotes], [*bug fixes*][temurin_openjdk17_bugfixes], [*Java 17 API*][oracle_openjdk17_api])
- [Temurin OpenJDK 21 LTS][temurin_openjdk21] ([*release notes*][temurin_openjdk21_relnotes], [*Java 21 API*][oracle_openjdk21_api])
- [Visual Studio Code 1.88][vscode_downloads] ([*release notes*][vscode_relnotes])

> **&#9755;** ***Installation policy***<br/>
> When possible we install software from a [Zip archive][zip_archive] rather than via a Windows installer. In our case we defined **`C:\opt\`** as the installation directory for optional software tools (*similar to* the [**`/opt/`**][linux_opt] directory on Unix).

For instance our development environment looks as follows (*May 2024*) <sup id="anchor_02">[2](#footnote_02)</sup>:

<pre style="font-size:80%;">
C:\opt\apache-maven\                       <i>( 10 MB)</i>
C:\opt\Git\                                <i>(367 MB)</i>
C:\opt\gradle\                             <i>(140 MB)</i>
C:\opt\jdk-temurin-11.0.23_9\              <i>(303 MB)</i>
C:\opt\jdk-temurin-17.0.11_9\              <i>(301 MB)</i>
C:\opt\jdk-temurin-21.0.3_9\               <i>(326 MB)</i>
C:\opt\msys64\                             <i>(2.8 GB)</i>
C:\opt\sbt\                                <i>(135 MB)</i>
C:\opt\scala-2.13.13\                      <i>( 24 MB)</i>
C:\opt\spark-3.5.1-bin-hadoop3\            <i>(423 MB)</i>
C:\opt\spark-3.5.1-bin-hadoop3-scala2.13\  <i>(432 MB)</i>
C:\opt\VSCode\                             <i>(352 MB)</i>
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
- directory [**`docs\`**](docs/) contains [Apache Spark][apache_spark] related papers/articles.
- directory [**`examples`**](examples/) contain [Apache Spark][apache_spark] code examples.
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

We execute command [**`setenv.bat`**](setenv.bat) once to setup our development environment; it makes external tools such as [**`mvn.cmd`**][apache_maven_cli], [**`sbt.bat`**][sbt_cli] or [**`sh.exe`**][sh_cli] directly available from the command prompt.

<pre style="font-size:80%;">
<b>&gt; <a href="setenv.bat">setenv</a></b>
Tool versions:
   java 11.0.22, sbt 1.9.9, scalac 2.13.13, spark-shell 3.5.1,
   gradle 8.7, mvn 3.9.6, make 4.4.1,
   git 2.44.0.windows.1, diff 3.10, bash 5.2.26(1)-release

<b>&gt; <a href="https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/where_1" rel="external">where</a> mvn sbt sh</b>
C:\opt\apache-maven\bin\mvn
C:\opt\apache-maven\bin\mvn.cmd
C:\opt\Git\bin\sh.exe
C:\opt\Git\usr\bin\sh.exe
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
<a href="https://maven.apache.org/download.cgi">apache-maven-3.9.6-bin.zip</a>                         <i>( 10 MB)</i>
<a href="https://gradle.org/install/">gradle-8.7-bin.zip</a>                                 <i>(118 MB)</i>
<a href="http://repo.msys2.org/distrib/x86_64/">msys2-x86_64-20240113.exe</a>                          <i>( 86 MB)</i>
<a href="https://adoptium.net/?variant=openjdk11">OpenJDK11U-jdk_x64_windows_hotspot_11.0.23_9.zip</a>   <i>(194 MB)</i>
<a href="https://adoptium.net/?variant=openjdk17">OpenJDK17U-jdk_x64_windows_hotspot_17.0.11_9.zip</a>   <i>(191 MB)</i>
<a href="https://adoptium.net/fr/temurin/releases/?variant=openjdk21&jvmVariant=hotspot">OpenJDK21U-jdk_x64_windows_hotspot_21.0.3_9.zip</a>    <i>(191 MB)</i>
<a href="https://git-scm.com/download/win">PortableGit-2.44.0-64-bit.7z.exe</a>                   <i>( 41 MB)</i>
<a href="https://github.com/sbt/sbt/releases">sbt-1.9.9.zip</a>                                      <i>( 17 MB)</i>
<a href="https://www.scala-lang.org/files/archive/">scala-2.13.13.zip</a>                                  <i>( 21 MB)</i>
<a href="https://spark.apache.org/downloads.html">spark-3.5.1-bin-hadoop3.tgz</a>                        <i>(285 MB)</i>
<a href="https://spark.apache.org/downloads.html">spark-3.5.1-bin-hadoop3-scala2.13.tgz</a>              <i>(292 MB)</i>
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
Concretely, in our GitHub projects which depend on Visual Studio (e.g. <a href="https://github.com/michelou/cpp-examples"><code>michelou/cpp-examples</code></a>), <a href="./setenv.bat"><code><b>setenv.bat</b></code></a> does invoke <code><b>VsDevCmd.bat</b></code> (resp. <code>vcvarall.bat</code> for older Visual Studio versions) to setup the Visual Studio tools on the command prompt. 
</dd></dl>

***

*[mics](https://lampwww.epfl.ch/~michelou/)/May 2024* [**&#9650;**](#top)
<span id="bottom">&nbsp;</span>

<!-- link refs -->

[ada_examples]: https://github.com/michelou/ada-examples
[akka_examples]: https://github.com/michelou/akka-examples
[apache_maven]: https://maven.apache.org/download.cgi
[apache_maven_cli]: https://maven.apache.org/ref/current/maven-embedder/cli.html
[apache_maven_history]: https://maven.apache.org/docs/history.html
[apache_maven_relnotes]: https://maven.apache.org/docs/3.9.6/release-notes.html
[apache_spark]: https://spark.apache.org
[apache_spark_sql]: https://spark.apache.org/docs/latest/sql-programming-guide.html
[cobol_examples]: https://github.com/michelou/cobol-examples
[cpp_examples]: https://github.com/michelou/cpp-examples
[dart_examples]: https://github.com/michelou/dart-examples
[deno_examples]: https://github.com/michelou/deno-examples
[docker_examples]: https://github.com/michelou/docker-examples
[flix_examples]: https://github.com/michelou/flix-examples
[git_cli]: https://git-scm.com/docs/git
[git_docs]: https://git-scm.com/docs/git
[git_downloads]: https://git-scm.com/download/win
[github_markdown]: https://github.github.com/gfm/
[git_relnotes]: https://raw.githubusercontent.com/git/git/master/Documentation/RelNotes/2.44.0.txt
[golang_examples]: https://github.com/michelou/golang-examples
[graalvm_examples]: https://github.com/michelou/graalvm-examples
[gradle_cli]: https://docs.gradle.org/current/userguide/command_line_interface.html
[gradle_compatibility]: https://docs.gradle.org/current/release-notes.html#upgrade-instructions
[gradle_install]: https://gradle.org/install/
[gradle_relnotes]: https://docs.gradle.org/8.7/release-notes.html
[hadoop_downloads]: https://hadoop.apache.org/releases.html
[haskell_examples]: https://github.com/michelou/haskell-examples
[kafka_examples]: https://github.com/michelou/kafka-examples
[kotlin_examples]: https://github.com/michelou/kotlin-examples
[linux_opt]: https://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/opt.html
[llvm_examples]: https://github.com/michelou/llvm-examples
[m2_examples]: https://github.com/michelou/m2-examples
[man1_awk]: https://www.linux.org/docs/man1/awk.html
[man1_diff]: https://www.linux.org/docs/man1/diff.html
[man1_file]: https://www.linux.org/docs/man1/file.html
[man1_grep]: https://www.linux.org/docs/man1/grep.html
[man1_more]: https://www.linux.org/docs/man1/more.html
[man1_mv]: https://www.linux.org/docs/man1/mv.html
[man1_rmdir]: https://www.linux.org/docs/man1/rmdir.html
[man1_sed]: https://www.linux.org/docs/man1/sed.html
[man1_wc]: https://www.linux.org/docs/man1/wc.html
[msys2_changelog]: https://github.com/msys2/setup-msys2/blob/main/CHANGELOG.md
[msys2_downloads]: http://repo.msys2.org/distrib/x86_64/
[nodejs_examples]: https://github.com/michelou/nodejs-examples
[oracle_openjdk17_api]: https://docs.oracle.com/en/java/javase/17/docs/api/
[oracle_openjdk21]: https://jdk.java.net/21/
[oracle_openjdk21_api]: https://docs.oracle.com/en/java/javase/21/docs/api/
[oracle_openjdk21_relnotes]: https://jdk.java.net/21/release-notes
[python_examples]: https://github.com/michelou/python-examples
[rust_examples]: https://github.com/michelou/rust-examples
[sbt_cli]: https://www.scala-sbt.org/1.x/docs/Command-Line-Reference.html
[sbt_downloads]: https://github.com/sbt/sbt/releases
[sbt_relnotes]: https://github.com/sbt/sbt/releases/tag/v1.9.9
[scala_releases]: https://www.scala-lang.org/files/archive/
[scala_relnotes]: https://github.com/scala/scala/releases/tag/v2.13.13
[scala3_examples]: https://github.com/michelou/dotty-examples
[sh_cli]: https://man7.org/linux/man-pages/man1/sh.1p.html
[spring_examples]: https://github.com/michelou/spring-examples
[spark_downloads]: https://spark.apache.org/downloads.html
<!--
3.3.2 -> https://spark.apache.org/releases/spark-release-3-3-2.html
3.4.1 -> https://spark.apache.org/releases/spark-release-3-4-1.html
3.5.0 -> https://spark.apache.org/releases/spark-release-3-5-0.html
3.4.1 -> https://spark.apache.org/releases/spark-release-3-5-1.html
-->
[spark_relnotes]: https://spark.apache.org/releases/spark-release-3-5-1.html
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
11.0.21 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-October/026351.html
11.0.22 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2024-January/029215.html
-->
[temurin_openjdk11]: https://adoptium.net/releases.html?variant=openjdk11&jvmVariant=hotspot
[temurin_openjdk11_bugfixes]: https://www.oracle.com/java/technologies/javase/11-0-17-bugfixes.html
[temurin_openjdk11_relnotes]: https://mail.openjdk.org/pipermail/jdk-updates-dev/2022-October/018119.html
<!--
17.0.7  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-April/021899.html
17.0.8  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-July/024063.html
17.0.9  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-October/026352.html
17.0.10 -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2024-January/029089.html
-->
[temurin_openjdk17]: https://adoptium.net/releases.html?variant=openjdk17&jvmVariant=hotspot
[temurin_openjdk17_bugfixes]: https://www.oracle.com/java/technologies/javase/17-0-2-bugfixes.html
[temurin_openjdk17_relnotes]: https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-October/026352.html
<!--
21_35   -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-October/026351.html
21.0.1  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-October/026351.html
21.0.2  -> https://mail.openjdk.org/pipermail/jdk-updates-dev/2024-January/029090.html
-->
[temurin_openjdk21]: https://adoptium.net/releases.html?variant=openjdk21&jvmVariant=hotspot
[temurin_openjdk21_bugfixes]: https://www.oracle.com/java/technologies/javase/17-0-2-bugfixes.html
[temurin_openjdk21_relnotes]: https://mail.openjdk.org/pipermail/jdk-updates-dev/2023-October/026351.html
[trufflesqueak_examples]: https://github.com/michelou/trufflesqueak-examples
[vscode_downloads]: https://code.visualstudio.com/#alt-downloads
[vscode_relnotes]: https://code.visualstudio.com/updates/
[windows_limitation]: https://support.microsoft.com/en-gb/help/830473/command-prompt-cmd-exe-command-line-string-limitation
[windows_subst]: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/subst
[wix_examples]: https://github.com/michelou/wix-examples
[zip_archive]: https://www.howtogeek.com/178146/
