import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["scroll"]
  connect() {
    this.scrollTarget.classList.add("scrollable");
  }
}
