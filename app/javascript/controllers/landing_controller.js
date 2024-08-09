import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame", "scroll"]
  connect() {
    console.log(this.frameTarget)
    // first div frame open up after 5 seconds, and disapear
    setTimeout(() => {
        // Apply slide-up animation to the frame
      this.frameTarget.classList.add("frame-slide-up");
    }, 3000);
    setTimeout(() => {
       window.location.href = '/bikes';
    }, 3400);
  }
}
