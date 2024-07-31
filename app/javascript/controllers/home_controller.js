import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame", "scroll"]
  connect() {
    // first div frame open up after 5 seconds, and disapear
    setTimeout(() => {
        // Apply slide-up animation to the frame
      this.frameTarget.classList.add("frame-slide-up");
    }, 3000);
    setTimeout(() => {
      this.scrollTarget.classList.add("scrollable");
    }, 3000);

    // show the second div home behind to go up
  }
}
