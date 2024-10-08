import { Controller } from "@hotwired/stimulus"
import confetti from 'canvas-confetti'

export default class extends Controller {
  static targets = ["amount", "goal"]

  connect() {
    console.log("Confetti controller connected")
  }

  checkConfetti() {
    const amount = parseInt(this.amountTarget.innerText)
    const goal = parseInt(this.goalTarget.dataset.goal)

    if (amount === goal -1) {
      this.launchConfetti()
    }
  }

  launchConfetti() {
    const bodyElement = document.querySelector('body');

    // Trigger confetti animation from the body
    if (bodyElement) {
      confetti({
        particleCount: 100,
        spread: 70,
        origin: { y: 0.6 }, // Launch from the middle of the page vertically
        zIndex: 9999, // Ensure it displays on top of everything
      });
    }
  }
}