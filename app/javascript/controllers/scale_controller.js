import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["amount"]

  connect() {
    // Optionally log to confirm controller is connected
    console.log("Scale controller connected")
  }

  scaleUp() {
    this.animateScale(1.2)  // Scale up the amount by 1.2 times
  }

  scaleDown() {
    this.animateScale(0.8)  // Scale down the amount to 80%
  }

  animateScale(scaleValue) {
    this.amountTarget.style.transition = "transform 0.2s ease-in-out"
    this.amountTarget.style.transform = `scale(${scaleValue})`

    // Reset the scale back to normal after the animation completes
    setTimeout(() => {
      this.amountTarget.style.transform = "scale(1)"
    }, 200)  // Same duration as transition time
  }
}