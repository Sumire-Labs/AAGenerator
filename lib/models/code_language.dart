enum CodeLanguage {
  bash('Bash', 'echo -e'),
  powershell('PowerShell', 'Write-Host'),
  python('Python', 'print'),
  javascript('JavaScript', 'console.log');

  final String displayName;
  final String printCommand;
  const CodeLanguage(this.displayName, this.printCommand);
}
