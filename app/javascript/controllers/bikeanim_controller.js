import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["anim"]
  connect() {
    setTimeout(() => {
      const index = window.location.pathname.includes('bikes');
      if(index) {
        this.animTarget.innerHTML = '';
      }
    }, 1300);
  }
}
