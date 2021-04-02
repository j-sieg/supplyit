import { Controller } from "stimulus"

export default class extends Controller {
  static classes = ['open']

  connect() {
    this.retainer = this.element.parentElement
    const opened = this.retainer.dataset.cartOpened === 'true'

    if (opened) {
      this.element.setAttribute('open', true)
      this.element.classList.add(this.openClass)
    } else {
      this.element.removeAttribute('open')
      this.element.classList.remove(this.openClass)
    }
  }

  toggle() {
    const open = !this.element.hasAttribute('open')
    if (open) {
      this.retainer.dataset.cartOpened = true
      this.element.classList.add(this.openClass)
    } else {
      this.retainer.dataset.cartOpened = false
      this.element.classList.remove(this.openClass)
    }
  }
}