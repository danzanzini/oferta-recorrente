import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "available", "total"]
  static values = { limit: Number }

  connect() {
    this.updateTotal()
  }

  increment(event) {
    const row = event.target.closest("[data-counter-row]")
    const input = row.querySelector("[data-counter-target='input']")
    const available = row.querySelector("[data-counter-target='available']")

    if (parseInt(available.textContent) > 0 && this.withinLimit()) {
      this.changeInputValue(input, 1)
      this.changeAvailableValue(available, -1)
      this.updateTotal()
    }
  }

  decrement(event) {
    const row = event.target.closest("[data-counter-row]")
    const input = row.querySelector("[data-counter-target='input']")
    const available = row.querySelector("[data-counter-target='available']")

    if (parseInt(input.value) > 0) {
      this.changeInputValue(input, -1)
      this.changeAvailableValue(available, 1)
      this.updateTotal()
    }
  }

  withinLimit() {
    if (!this.hasLimitValue || this.limitValue === 0) return true
    return this.currentTotal() < this.limitValue
  }

  currentTotal() {
    return this.inputTargets.reduce((sum, input) => sum + (parseInt(input.value) || 0), 0)
  }

  updateTotal() {
    if (this.hasTotalTarget) {
      this.totalTarget.textContent = this.currentTotal()
    }
  }

  changeInputValue(input, delta) {
    let value = parseInt(input.value) || 0
    input.value = value + delta
  }

  changeAvailableValue(available, delta) {
    let value = parseInt(available.textContent) || 0
    available.textContent = value + delta
  }
}
