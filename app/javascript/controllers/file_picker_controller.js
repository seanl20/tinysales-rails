import { Controller } from "@hotwired/stimulus"
import axios from 'axios';

// Connects to data-controller="file-picker"
export default class extends Controller {
  static targets = [ 'button', 'fileInput' ];

  connect() {
    console.log('axios: ', axios);
  }

  open() {
    this.fileInputTarget.click();
  }

  uploadFiles(e) {
    console.log('uploadFiles', Array.from(e.target.files));

    axios.post('/api/contents', {
      name: e.target.files[0].name
    }, {
      headers: {
        'ACCEPT': 'application/json'
      }
    });
  }
}
