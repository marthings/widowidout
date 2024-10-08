import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {

    this.timeout = setTimeout(() => {

      this.timeout = setTimeout(() => {
        this.element.remove()
      }, 4000)
    }, 4000)
  }
}
