import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static values = {
    disabledDates: Array
  }

  connect() {
    flatpickr(this.element, {
      mode:"range",
      inline: true,
      disable: this.disabledDatesValue
    })
  }
}
