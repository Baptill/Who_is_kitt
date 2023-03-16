// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import { gameAnimation } from "./animations/gameAnimation"


window.addEventListener('DOMContentLoaded', (e) => {
  gameAnimation()
})
