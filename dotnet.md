Install the .NET Core SDK, which includes NuGet capabilities. Downloads are also listed on github.com/dotnet/cli.
Install Mono and then use the nuget.exe command-line executable for Windows (version 3.2 and later) from nuget.org/downloads. Running NuGet on Mono is subject to the following limitations:

package
=======================

iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install nuget.commandline
