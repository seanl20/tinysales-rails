import { Controller } from "@hotwired/stimulus"

  const ImageTypes = ['image/gif', 'image/jpeg', 'image/png'];

// Connects to data-controller="product-form"
export default class extends Controller {
  static targets = ['thumbnail', 'thumbnailInput', 'coverInput', 'cover' ];

  connect() {
    console.log("Thumbnail: ", this.thumbnailTarget)
  }

  changeCover(e) {
    e.preventDefault();
    this.coverInputTarget.click();
  }

  attachCover(e) {
    e.preventDefault();

    const file = e.target.files[0];

    if(!ImageTypes.includes(file.type)){
      alert('Attached file must be an image!');
    }

    this.coverInputTarget.files = e.target.files;
    this.coverTarget.src = URL.createObjectURL(file);
  }

  changeThumbnail(e) {
    e.preventDefault();
    this.thumbnailInputTarget.click();
  }

  attachThumbnail(e) {
    e.preventDefault();

    const file = e.target.files[0];
    console.log("inside attach thumbnail: ", file);

    if(!ImageTypes.includes(file.type)){
      alert('Attached file must be an image!');
    }

    this.thumbnailInputTarget.files = e.target.files;
    this.thumbnailTarget.src = URL.createObjectURL(file);
  }
}
