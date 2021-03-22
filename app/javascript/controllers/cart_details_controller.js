import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.retainer = this.element.parentElement
    const opened = this.retainer.dataset.cartOpened === 'true'

    if (opened) {
      this.element.setAttribute('open', true)
    } else {
      this.element.removeAttribute('open')
    }
  }

  toggle() {
    const open = !this.element.hasAttribute('open')
    if (open) {
      this.retainer.dataset.cartOpened = true
    } else {
      this.retainer.dataset.cartOpened = false
    }
  }
}