import { Controller} from "@hotwired/stimulus"

export default class extends Controller {
  initialize() {}
  connect() {}
  myFilter(event){
    event.preventDefault();
    event.stopPropagation();
    const filter = document.getElementById("filter");
    filter.classList.toggle("d-none");
  }
}