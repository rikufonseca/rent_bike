import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame", "content", "bikeVideo"]
  connect() {
    if(this.bikeVideoTarget) {
      document.body.style.display = 'none'
      this.bikeVideoTarget.addEventListener('canplay', () => {
        // Unblock page load when video is ready
        document.body.style.display = 'block'
      })
    }

    setTimeout(() => {
        // Apply slide-up animation to the frame
      this.frameTarget.classList.add("frame-slide-up")
    }, 3000)
  }
}
