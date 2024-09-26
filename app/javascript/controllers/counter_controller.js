import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  connect() {
    // Initialize the counter value if needed
  }

  increment() {
    const input = this.inputTarget
    let value = parseInt(input.value) || 0
    input.value = value + 1
    this.updateAvailability()
  }

  decrement() {
    const input = this.inputTarget
    let value = parseInt(input.value) || 0
    if (value > 0) {
      input.value = value - 1
      this.updateAvailability()
    }
  }

  updateAvailability() {
    // You can add logic here to update the availability or perform other actions
    // This method is called after each increment or decrement
  }
}