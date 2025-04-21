import { Controller } from "@hotwired/stimulus"
import { enter, leave } from 'el-transition'

// Connects to data-controller="notification"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      enter(this.element);
    }, 500);

    // Auto-hide
    setTimeout(() => {
      this.close();
    }, 5000);
  }

  close(){
    leave(this.element);

    // Remove after transition
    setTimeout(() => {
      this.element.remove
    }, 300);
  }
}
