import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame", "content", "bikeVideo", "price", "priceSlider"]
  connect() {
    if(this.bikeVideoTarget) {
      document.body.style.visibility = 'hidden'
      document.body.style.backgroundColor = 'white'
      this.bikeVideoTarget.addEventListener('canplay', () => {
        // Unblock page load when video is ready
        document.body.removeAttribute('style')
      })
    }

    setTimeout(() => {
        // Apply slide-up animation to the frame
      this.frameTarget.classList.add("frame-slide-up")
    }, 3000)

    this.priceTarget.innerHTML = `$${this.priceSliderTarget.value}`;

    this.priceSliderTarget.addEventListener('input', (event) => {
      this.priceTarget.innerHTML = `$${event.target.value}`
    })
  }
}
