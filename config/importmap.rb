# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "el-transition", to: "https://cdn.jsdelivr.net/npm/el-transition@0.0.7" # @0.0.7
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "axios", to: "https://cdn.skypack.dev/axios@1.9.0" # @1.9.0
pin "https://cdn.skypack.dev/-/axios@v1.9.0-xXVbkXf0shxDVskkAq6q/dist=es2019,mode=raw/lib/adapters/http.js", to: "https:----cdn.skypack.dev-----axios@v1.9.0-xXVbkXf0shxDVskkAq6q--dist=es2019,mode=raw--lib--adapters--http.js.js" #
pin "https://cdn.skypack.dev/-/axios@v1.9.0-xXVbkXf0shxDVskkAq6q/dist=es2019,mode=raw/lib/platform/node/classes/FormData.js", to: "https:----cdn.skypack.dev-----axios@v1.9.0-xXVbkXf0shxDVskkAq6q--dist=es2019,mode=raw--lib--platform--node--classes--FormData.js.js" #
pin "https://cdn.skypack.dev/-/axios@v1.9.0-xXVbkXf0shxDVskkAq6q/dist=es2019,mode=raw/lib/platform/node/index.js", to: "https:----cdn.skypack.dev-----axios@v1.9.0-xXVbkXf0shxDVskkAq6q--dist=es2019,mode=raw--lib--platform--node--index.js.js" #
pin "pretty-bytes" # @7.0.0
