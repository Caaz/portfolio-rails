# Pin npm packages by running ./bin/importmap
pin "application", preload: true
# pin_all_from "app/javascript/controllers", under: "controllers"
pin "uikit", to: "https://ga.jspm.io/npm:uikit@3.16.22/dist/js/uikit.js"

pin "application/home"
pin "application/notifier"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
