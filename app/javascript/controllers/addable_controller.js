import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['addButton']
  static classes = ['added', 'failed']

  initialize() {
    this.addButtonTarget.addEventListener('turbo:submit-end', this.add.bind(this))
  }

  add(event) {
    const pureElement = this.element
    if (event.detail.success) {
      this.element.classList.remove(this.failedClass)
      this.element.classList.add(this.addedClass)
    } else {
      this.element.classList.add(this.failedClass)
    }
    this.element.parentNode.replaceChild(this.element, pureElement)
  }

  disconnect() {
    this.addButtonTarget.removeEventListener('turbo:submit-end', this.add.bind(this))
  }
}