// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./custom/content_new"
import "./custom/modal"

import { Application } from "@hotwired/stimulus"
import Autocomplete from "stimulus-autocomplete"

const application = Application.start()
application.register("autocomplete", Autocomplete)


import '@fortawesome/fontawesome-free'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { far } from '@fortawesome/free-regular-svg-icons'
import { fab } from '@fortawesome/free-brands-svg-icons'
import { library } from "@fortawesome/fontawesome-svg-core";
library.add(fas, far, fab)

import * as bootstrap from "bootstrap"
