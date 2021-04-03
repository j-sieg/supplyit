import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['addButton']
  static classes = ['added', 'failed']

  initialize() {
    this.pureElement = this.element
  }

  add(event) {
    if (event.detail.success) {
      this.element.classList.remove(this.failedClass)
      this.element.classList.add(this.addedClass)
    } else {
      this.element.classList.add(this.failedClass)
    }

    // remove the growing spinner and enable the add to cart button
    this.addButtonTarget.nextElementSibling.remove()
    this.addButtonTarget.removeAttribute('disabled')

    this.element.parentNode.replaceChild(this.element, this.pureElement)
  }

  progress(event) {
    this.addButtonTarget.insertAdjacentHTML("afterend", `
      <div class="spinner-grow ms-2" role="status">
        <span class="visually-hidden"> Adding... </span>
      </div>
    `)
    this.addButtonTarget.setAttribute('disabled', true)
  }

}