import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="buzzer"
export default class extends Controller {
  static targets = ["wrapper"]

  connect() {
  }

  add() {
    console.log("Hello");
    this.wrapperTarget.classList.add("buzzer-animation")
    setTimeout(() => {
      this.wrapperTarget.classList.remove("buzzer-animation")
    }, 3000);
  }
}
