import { Controller } from "@hotwired/stimulus"
import axios from 'axios';
import { post } from "@rails/request.js"

let files = [];
const csrfToken = document.querySelector('meta[name=csrf-token]').getAttribute('content');

// Connects to data-controller="file-picker"
export default class extends Controller {
  static targets = [ 'button', 'fileInput', 'content' ];

  HEADERS = {
    'ACCEPT': 'text/vnd.turbo-stream.html',
    'X-CSRF-Token': csrfToken
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
      },{ headers: this.HEADERS
      }).then((response) => {
        const contentId = response.data.match(/data-content-id=("\d+")/)[1].replace(/"|'/g, '');
        file['contentId'] = parseInt(contentId);
        files.push(file);
        Turbo.renderStreamMessage(response.data);
      });
    });
  }

  buildContentParam(fileComponent) {
    const contentId = parseInt(fileComponent.dataset.contentId);
    const name = fileComponent.querySelector('input[name="name"]').value;
    const description = fileComponent.querySelector('input[name="description"]').value;

    return {
      id: contentId,
      name: name,
      description: description
    }
  }

  getUploadedFileComponents(){
    return Array.from(document.getElementsByClassName('uploaded-file-component'));
  }

  async submitForm(e){
    e.preventDefault();
    const productId = this.element.dataset.productId;
    const contents = [];

    const params = new FormData();

    this.getUploadedFileComponents().forEach((fileComponent) => {
      contents.push(this.buildContentParam(fileComponent));
    });

    const response = await post(`/products/${productId}/attach_contents`, { body: { contents: contents }, responseKind: 'turbo-stream' })

    if (response.ok) {
      Turbo.visit(`/products/${productId}/edit`);
    }
  }

}
