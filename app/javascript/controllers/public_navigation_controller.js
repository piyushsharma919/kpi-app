import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "toggle"]

  connect() {
    // Close menu when clicking outside
    document.addEventListener("click", this.handleClickOutside.bind(this))
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside.bind(this))
  }

  toggle() {
    this.menuTarget.classList.toggle("is-active")
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target) && this.menuTarget.classList.contains("is-active")) {
      this.menuTarget.classList.remove("is-active")
    }
  }
}
