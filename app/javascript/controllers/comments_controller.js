import { Controller} from "@hotwired/stimulus"

export default class extends Controller {
	initialize() { }
	connect() { }
	taggleForm(event) {
	event.preventDefault();
	event.stopPropagation();
	const formID = event.params["form"];
	// const commentBodyID = event.params["body"];
	const form = document.getElementById(formID);
	// const commentBody = document.getElementById(commentBodyID);
	form.classList.toggle("d-none");
	// commentbody.classList.toggle("d-none");
	}
	
}