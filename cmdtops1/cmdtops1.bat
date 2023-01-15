<# :
@ECHO OFF
SETLOCAL
TYPE %~f0 | powershell -NoLogo -ExecutionPolicy RemoteSigned -&goto:eof
ENDLOCAL
@ECHO ON
@GOTO :EOF
#>

#
#  Reference Documents
#
#  About Execution Policies
#
#  https://learn.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7.3
#
#  Syntax of Comment-Based Help
#  https://learn.microsoft.com/en-us/powershell/scripting/developer/help/syntax-of-comment-based-help?view=powershell-7.3
#
#  How to run a PowerShell script within a Windows batch file
#  https://stackoverflow.com/questions/2609985/how-to-run-a-powershell-script-within-a-windows-batch-file
#

Write-Output "Hello World"
