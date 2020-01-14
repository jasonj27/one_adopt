require("@rails/ujs").start()
// require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import '../scripts/index.js'
import '../stylesheets/index.js'
import 'jquery'
import "controllers"

const images = require.context("../images", true)
const imagePath = (name) => images(name, true)

require("trix")
require("@rails/actiontext")
import './trix-overrides.js'

document.addEventListener("DOMContentLoaded", function() {
  $('.toast').toast('show')
})