import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['fileField']

  connect() {
    this.fileFieldTarget.addEventListener('direct-upload:initialize', this.displayBusy)
    this.fileFieldTarget.addEventListener('direct-upload:end', this.completed)
  }

  displayBusy(event) {
    const { target } = event
    const { id, file } = event.detail
    target.insertAdjacentHTML("afterend", `
      <button id="direct-upload-${id}" class="btn btn-sm btn-dark mt-2" type="button" disabled>
        <span class="spinner-grow spinner-grow-sm" role="status" aria-hidden="true"></span>
        <span></span>
      </button>
    `)
    target.nextElementSibling.lastElementChild.textContent = file.name
  }

  completed(event) {
    const { id } = event.detail
    const target = document.getElementById(`direct-upload-${id}`)
    target.firstElementChild.remove()
  }

  disconnect() {
    this.fileFieldTarget.removeEventListener('direct-upload:initialize', this.completed)
  }
}
