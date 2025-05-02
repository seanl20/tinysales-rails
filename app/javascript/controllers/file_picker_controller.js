import { Controller } from "@hotwired/stimulus"
import axios from 'axios';

const files = [];

// Connects to data-controller="file-picker"
export default class extends Controller {
  static targets = [ 'button', 'fileInput', 'content' ];

  HEADERS = {
    'ACCEPT': 'text/vnd.turbo-stream.html'
  }

  connect() {
    console.log('axios: ', axios);
  }

  open() {
    this.fileInputTarget.click();
  }

  addContent(content) {
    contents.push(content);
  }

  attachFile(content) {
    content.attachFile(files[0]);
    content.uploadFile()
  }

  uploadFiles(e) {
    files.push(e.target.files[0]);

    axios.post('/api/contents', {
      name: e.target.files[0].name,
      file_size: e.target.files[0].size,
      file_type: e.target.files[0].type
    }, { headers: this.HEADERS })
    .then((response) => {
      Turbo.renderStreamMessage(response.data)
      const contentId = response.data.match(/data-content-id=("\d+")/)[1].replace(/"|'/g, '')
    });
  }
}
