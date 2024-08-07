import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["frame", "scroll", "form", "list", "searchInput"]
  connect() {
    // first div frame open up after 5 seconds, and disapear
    setTimeout(() => {
        // Apply slide-up animation to the frame
      this.frameTarget.classList.add("frame-slide-up");
    }, 3000);
    setTimeout(() => {
      this.scrollTarget.classList.add("scrollable");
    }, 3000);
  }
  update() {
    const url = `${this.formTarget.action}?query=${this.searchInputTarget.value}`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data;
    })
  }
}
