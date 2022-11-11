import { stat } from 'os'
(() => {
  // src/module.js
  var module_default = (name) => {
  };

  // src/main.js
  console.log("hello quickjs");
  console.log("hahahh", stat);
  module_default("hahahah hello");
})();
