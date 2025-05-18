import { Controller } from "@hotwired/stimulus"
import axios from 'axios'
import { destroy } from "@rails/request.js"
import prettyBytes from 'pretty-bytes'

let file = null;

// Connects to data-controller="uploaded-file"
export default class extends Controller {
  static targets = ['form', 'open', 'close', 'metaData', 'uploadProgress'];
  static outlets = [ 'file-picker' ];

  connect() {
    if(this.element.dataset.uploadCompleted !== 'true'){
      this.filePickerOutlet.attachFile(this);
    }
  }

  attachFile(attachedFile) {
    file = attachedFile;
  }

  uploadFile() {
    const csrfToken = document.querySelector('meta[name=csrf-token]').getAttribute('content');

    const config = {
      onUploadProgress: (progressEvent) => {
        const percentCompleted = Math.round( ( progressEvent.loaded * 100 ) / progressEvent.total );
        this.uploadProgressTarget.classList.remove('hidden')
        this.metaDataTarget.classList.add('hidden')
        this.uploadProgressTarget.textContent = this.uploadProgressText(percentCompleted, progressEvent.rate);
      },
      headers: {
        'ACCEPT': 'application/json',
        'X-CSRF-Token': csrfToken
      }
    }

    const data = new FormData();
    data.append('content[file]', file);


    axios.put(`/api/contents/${this.element.dataset.contentId}`, data, config)
    .then((response) => {
      this.uploadProgressTarget.classList.add('hidden')
      this.metaDataTarget.classList.remove('hidden')
    });
  }

  uploadProgressText(percentageCompleted, uploadRate) {
    const totalFileSize = this.uploadProgressTarget.dataset.fileSize;
    const fileType = this.uploadProgressTarget.dataset.fileType;

    if (uploadRate === undefined) return;

    return `${fileType} · ${percentageCompleted}% of ${totalFileSize} (${prettyBytes(uploadRate).toUpperCase()}/second)`
  }

  open(e) {
    e.preventDefault();
    this.openTarget.classList.add('hidden');
    this.closeTarget.classList.remove('hidden');
    this.formTarget.classList.remove('hidden');
  }

  close(e) {
    e.preventDefault();
    this.openTarget.classList.remove('hidden');
    this.closeTarget.classList.add('hidden');
    this.formTarget.classList.add('hidden');
  }

  async delete(e) {
    e.preventDefault();

    const response = await destroy(`/api/contents/${this.element.dataset.contentId}`, { headers: {
      'ACCEPT': 'application/json'
    }});

    if (response.ok) {
      this.element.remove();
    }
  }
}
