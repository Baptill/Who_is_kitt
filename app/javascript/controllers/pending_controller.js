import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["audio"]

  playSound() {

   this.audioTarget.play()

  }
}
