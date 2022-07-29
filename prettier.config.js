module.exports = {
  printWidth: 120,
  overrides: [
    {
      files: ['*.ts', '*.tsx'],
      options: { parser: 'typescript' }
    }
  ],
  singleQuote: true,
  arrowParens: 'avoid'
};
