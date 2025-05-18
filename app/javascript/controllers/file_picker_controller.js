import { Controller } from "@hotwired/stimulus"
import axios from 'axios';
import { post } from "@rails/request.js"

let files = [];

// Connects to data-controller="file-picker"
export default class extends Controller {
  static targets = [ 'button', 'fileInput', 'content' ];

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

  async uploadFiles(e) {
    const csrfToken = document.querySelector('meta[name=csrf-token]').getAttribute('content');

    Array.from(e.target.files).forEach((file) => {
      const params = new FormData();
      params.append("content[name]", file.name);
      params.append("content[file_size]", file.size);
      params.append("content[file_type]", file.type);

      const response = post('/api/contents', { query: params, headers: {
        'ACCEPT': 'text/vnd.turbo-stream.html'
      }});

      if (response.ok) {
        const contentId = response.data.match(/data-content-id=("\d+")/)[1].replace(/"|'/g, '');
        file['contentId'] = parseInt(contentId);
        files.push(file);
        Turbo.renderStreamMessage(response.data);
      }

      axios.post('/api/contents', {
      }, { headers: {
          'ACCEPT': 'text/vnd.turbo-stream.html',
          'X-CSRF-Token': csrfToken
        }
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

  submitForm(e){
    e.preventDefault();
    const productId = this.element.dataset.productId;
    const contents = [];

    this.getUploadedFileComponents().forEach((fileComponent) => {
      contents.push(this.buildContentParam(fileComponent));
    });
    
    axios.post(`/products/${productId}/attach_contents`, {
      contents: contents
    })
    .then((response) => {
      Turbo.visit(`/products/${productId}/edit`);
    });
  }

}
