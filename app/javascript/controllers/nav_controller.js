import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["group"]

  toggleGroup(event) {
    const group = event.currentTarget.closest('.dashboard__nav-group')
    group.classList.toggle('is-open')
  }

  connect() {
    // Close submenus when clicking outside
    document.addEventListener('click', this.handleClickOutside.bind(this))
  }

  disconnect() {
    document.removeEventListener('click', this.handleClickOutside.bind(this))
  }

  handleClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.groupTargets.forEach(group => {
        group.classList.remove('is-open')
      })
    }
  }
}
