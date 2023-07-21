# Pin npm packages by running ./bin/importmap
pin "application", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/classes", under: "classes"
pin "uikit", to: "https://ga.jspm.io/npm:uikit@3.16.22/dist/js/uikit.js"
pin "uikit-icons", to: "https://ga.jspm.io/npm:uikit@3.16.22/dist/js/uikit-icons.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"