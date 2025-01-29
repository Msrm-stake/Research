import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form"];

  toggle(event) {
    const replyForm = this.formTarget;
    replyForm.style.display = replyForm.style.display === 'none' || replyForm.style.display === '' ? 'block' : 'none';
  }
}
