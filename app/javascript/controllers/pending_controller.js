import { Controller } from "@hotwired/stimulus"
import gsap from "gsap"

export default class extends Controller {
  static targets = ["audio", "vs"]

  connect(){
    gsap.from(this.vsTarget, {
      duration: 1.0,
      delay: 1.0,
      scale: 8,
      opacity:0,
      ease: "bounce.out"
    })
  }
  playSound() {
    this.audioTarget.play()
  }
}
