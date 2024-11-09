import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "available"]

  connect() {
  }

  increment() {
    if (this.canIncrement(this.availableTarget)) {
      this.updateInputValue(this.inputTarget, 1)
      this.updateAvailableValue(this.availableTarget, -1)
    }
  }

  decrement() {
    if (this.canDecrement(this.inputTarget)) {
      this.updateInputValue(this.inputTarget, -1)
      this.updateAvailableValue(this.availableTarget, 1)
    }
  }

  canIncrement(available) {
    return parseInt(available.textContent) > 0
  }

  canDecrement(input) {
    return parseInt(input.value) > 0
  }

  updateInputValue(input, delta) {
    let value = parseInt(input.value) || 0
    input.value = value + delta
  }

  updateAvailableValue(available, delta) {
    let value = parseInt(available.textContent) || 0
    available.textContent = value + delta
  }
}