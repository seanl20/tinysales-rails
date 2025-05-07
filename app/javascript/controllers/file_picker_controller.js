import { Controller } from "@hotwired/stimulus"
import axios from 'axios';

let files = [];

// Connects to data-controller="file-picker"
export default class extends Controller {
  static targets = [ 'button', 'fileInput', 'content' ];

  HEADERS = {
    'ACCEPT': 'text/vnd.turbo-stream.html'
  }

  open() {
    this.fileInputTarget.click();
  }

  addContent(content) {
    contents.push(content);
  }

  attachFile(content) {
    const contentId = content.element.dataset.contentId;
    const fileIndex = files.findIndex(file => file.contentId == contentId);
    content.attachFile(files[fileIndex]);
    files = files.splice(fileIndex, fileIndex)
    content.uploadFile();
  }

  uploadFiles(e) {
    Array.from(e.target.files).forEach((file) => {
      axios.post('/api/contents', {
        name: file.name,
        file_size: file.size,
        file_type: file.type
      }, { headers: this.HEADERS })
      .then((response) => {
        const contentId = response.data.match(/data-content-id=("\d+")/)[1].replace(/"|'/g, '');
        file['contentId'] = parseInt(contentId);
        files.push(file);
        Turbo.renderStreamMessage(response.data);
      });
    });
  }

  getUploadedFileComponent(){
    return Array.from(document.getElementsByClassName('uploaded-file-component'));
  }

  submitForm(e){
    e.preventDefault();
    const productId = this.element.dataset.productId;
    const contentIds = this.getUploadedFileComponent().map((file) => {
      return parseInt(file.dataset.contentId)
    });
    console.log('Product Id: ', productId);
    console.log('content Ids: ', contentIds);
    console.log('TEST FORM SUBMIT');
  }
}
