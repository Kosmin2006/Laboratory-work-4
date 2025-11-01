export default [
  {
    files: ["**/*.js"],
    languageOptions: {
      ecmaVersion: 2021,
      sourceType: "module",
    },
    rules: {
      semi: "error",          // вимагає крапки з комою
      "no-undef": "error",    // забороняє невизначені змінні
      "no-unused-vars": "warn",
      "quotes": ["error", "double"],
      "indent": ["error", 2],
    },
  },
];
