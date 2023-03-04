# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "crypto-js" # @4.1.1
pin "crypto" # @2.0.1
pin "blueimp-md5", to: "https://ga.jspm.io/npm:blueimp-md5@2.19.0/js/md5.js"
