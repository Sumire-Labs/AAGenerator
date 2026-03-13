enum OutputFormat {
  plain('プレーンテキスト'),
  discord('Discord'),
  ansiEscape('ANSI Escape'),
  codeSnippet('コードスニペット');

  final String displayName;
  const OutputFormat(this.displayName);
}
