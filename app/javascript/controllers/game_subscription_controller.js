import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {

  static values = { gameId: Number }
  static targets = ["board"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "GameChannel", id: this.gameIdValue },
      { received: (reload) => {
        if (reload) {
          location.reload()
        }
      } }
    )
    console.log(`Subscribe to the game with the id ${this.gameIdValue}.`)
  }
}
