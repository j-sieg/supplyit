import { Controller } from 'stimulus'
import { Modal } from 'bootstrap'

export default class extends Controller {
  static targets = ['body', 'submitForm', 'errorMessage']

  initialize() {
    this.modal = new Modal(this.element)
    if(this.hasSubmitFormTarget) {
      this.submitFormTarget.addEventListener('turbo:submit-end', this.handleSubmit.bind(this))
    }
  }

  handleSubmit({ detail }) {
    // assume a success
    this.errorMessageTarget.classList.add('d-none')
    this.bodyTarget.classList.remove('failed__submit')
    const pureElement = this.element

    if (detail.success) {
      this.modal.hide()
    } else {
      this.errorMessageTarget.classList.remove('d-none')
      this.bodyTarget.classList.add('failed__submit')
    }

    this.element.parentNode.replaceChild(this.element, pureElement)
  }

  disconnect() {
    if (this.hasSubmitFormTarget) {
      this.submitFormTarget.removeEventListener('turbo:submit-end', this.handleSubmit.bind(this))
    }
  }
}
