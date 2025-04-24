import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="file-picker"
export default class extends Controller {
  static targets = [ 'button', 'fileInput' ];

  open() {
    this.fileInputTarget.click();
  }

  uploadFiles(e) {
    console.log('uploadFiles', Array.from(e.target.files));
  }
}
