import { Controller} from "@hotwired/stimulus"

export default class extends Controller {
	initialize() { }
	connect() { }
	taggleForm(event) {
		event.preventDefault();
		event.stopPropagation();
		const formID = event.params["form"];
		const form = document.getElementById(formID);
		form.classList.toggle("d-none");
	}

	myComment(event) {
		event.preventDefault();
		event.stopPropagation();
	  const comment = document.getElementById("comment");
	  comment.classList.toggle("d-none") 
	}
	
}