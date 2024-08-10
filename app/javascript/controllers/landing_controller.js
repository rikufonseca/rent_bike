import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame"]
  connect() {
    setTimeout(() => {
        // Apply slide-up animation to the frame
      this.frameTarget.classList.add("frame-slide-up");
    }, 3000);
    setTimeout(() => {
       window.location.href = '/bikes';
    }, 3400);
  }
}
