import { Controller } from "@hotwired/stimulus"
import axios from 'axios';
import prettyBytes from 'pretty-bytes';

let file = null;

// Connects to data-controller="uploaded-file"
export default class extends Controller {
  static targets = ['form', 'open', 'close', 'metaData', 'uploadProgress'];
  static outlets = [ 'file-picker' ];

  HEADERS = {
    'ACCEPT': 'application/json'
  }

  connect() {
    if(this.element.dataset.uploadCompleted !== 'true'){
      this.filePickerOutlet.attachFile(this);
    }
  }

  attachFile(attachedFile) {
    file = attachedFile;
  }

  uploadFile() {
    const config = {
      onUploadProgress: (progressEvent) => {
        const percentCompleted = Math.round( ( progressEvent.loaded * 100 ) / progressEvent.total );
        this.uploadProgressTarget.classList.remove('hidden')
        this.metaDataTarget.classList.add('hidden')
        this.uploadProgressTarget.textContent = this.uploadProgressText(percentCompleted, progressEvent.rate);
      },
      headers: this.HEADERS
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

  delete(e) {
    e.preventDefault();

    axios.delete(`/api/contents/${this.element.dataset.contentId}`,
      { headers: this.HEADERS }
    ).then((_) => {
      this.element.remove();
    });
  }
}
