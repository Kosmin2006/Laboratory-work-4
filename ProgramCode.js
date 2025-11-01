export default [
  {
    files: ["**/*.js"],
    languageOptions: {
      ecmaVersion: "latest",
      sourceType: "module",
    },
    rules: {
      semi: ["error", "always"],
      "no-unused-vars": "error",
      "no-undef": "error",
    },
  },
];
function main() {
  const productName = "MyLearningSystem";
  console.log(`Назва програмного продукту: ${productName}`);
}

main();
