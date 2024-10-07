import { Controller } from "@hotwired/stimulus";


export default class extends Controller {
  static targets = ["picker", "input", "popover"];

  connect() {
    this.pickerTarget.addEventListener("emoji-click", (event) => {
      this.inputTarget.value = event.detail.unicode;
      this.popoverTarget.hidePopover();
    });
  }

}