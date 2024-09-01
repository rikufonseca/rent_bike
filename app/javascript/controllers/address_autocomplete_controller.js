import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="address-autocomplete"
export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["address"]
  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      placeholder: "Enter a zip code or an address here",
      bbox: [3.358, 50.750 , 7.227, 53.725],
      language: "en,nl",
      types: "region,place,postcode,locality,neighborhood,address",
      country: "NL",
      proximity: {
        longitude: 4.9041,
        latitude: 52.3676
      }
    })

    this.geocoder.addTo(this.element)
    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  disconnect() {
    this.geocoder.onRemove()
  }

  #setInputValue(event) {
    this.addressTarget.value = event.result["place_name"]
  }

  #clearInputValue() {
    this.addressTarget.value = ""
  }
}
