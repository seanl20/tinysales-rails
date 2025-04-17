import { Controller } from '@hotwired/stimulus'
import { enter, leave } from 'el-transition'

// Connects to data-controller="sidenav"
export default class extends Controller {
  static targets = ['nav', 'backdrop', 'canvas']

  openSideNav(){
    this.navTarget.classList.remove('hidden');
    enter(this.backdropTarget);
    enter(this.canvasTarget);
  }

  closeSideNav(){
    leave(this.backdropTarget);
    leave(this.canvasTarget);
    setTimeout(()=> {
      this.navTarget.classList.add('hidden');
    }, 300)
  }
}
