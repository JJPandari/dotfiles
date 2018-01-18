module.exports = {
  extends: [
    'plugin:vue/recommended',
    'standard'
  ],
  env: {
    'browser': true,
    'node': true
 },
  globals: {
    $: true,
    jQuery: true,
    jquery: true
 },
  rules: {
    // override/add rules settings here, such as:
    // 'vue/no-unused-vars': 'error'
    "no-cond-assign": 'off',
    "comma-dangle": 'off',
    "no-delete-var": 'off',
    semi: 'off',
    "no-fallthrough": 'off',
    "no-floating-decimal": 'off',

    eqeqeq: 'off',
    indent: ['error', 2],
    'space-before-function-paren': 'warn',
    'keyword-spacing': 'warn',
    'semi-spacing': 'off',
    'space-infix-ops': 'off'
    // 'keyword-spacing': ['error', { overrides: {
    //   if: { after: false },
    //   for: { after: false },
    //   while: { after: false }
    // } }]
  }
}
