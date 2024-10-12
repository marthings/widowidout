import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["amount", "emoji"]

  connect() {
    // Optionally log to confirm controller is connected
    console.log("Scale controller connected")
  }

  scaleUp() {
    this.animateScale(2)  // Scale up the amount by 1.2 times
    this.amountTarget.style.rotate = "2deg"
    this.amountTarget.style.translate = "0px -20px"
  }

  scaleDown() {
    this.animateScale(0.8)  // Scale down the amount to 80%
    this.amountTarget.style.rotate = "-2deg"
    this.amountTarget.style.translate = "0px 20px"
  }

  animateScale(scaleValue) {
    this.amountTarget.style.transition = "transform 0.3s ease-in-out"
    
    
    this.amountTarget.style.transform = `scale(${scaleValue})`

    // Reset the scale back to normal after the animation completes
    setTimeout(() => {
      this.amountTarget.style.transform = "scale(1)"
    }, 300)  // Same duration as transition time
  }
}