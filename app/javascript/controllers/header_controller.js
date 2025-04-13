import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "dropdown"]

  connect() {
    document.addEventListener("click", this.handleClickOutside.bind(this))
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside.bind(this))
  }

  toggle(event) {
    event.preventDefault()
    this.dropdownTarget.classList.toggle("is-open")
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.dropdownTarget?.classList.remove("is-open")
    }
  }
}
