import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game-logic"
export default class extends Controller {
  static targets = ["timeBar", "timer"]

  connect() {
    let crono = this.timerTarget
    let cpt = 30

    setInterval(function(){
      if (cpt>0) {
          --cpt; // décrémente le compteur
          let old_contenu = crono.firstChild; // stock l'ancien contenu
          crono.removeChild(old_contenu); // supprime le contenu
          let texte = document.createTextNode(cpt); // crée le texte
          crono.innerText = cpt
      }
      else {
        clearInterval(this.timer)
      }
  }, 1000);
}

  restart(e) {
    this.timeBarTarget.classList.remove('animate-timer')
    setTimeout(() => {
      this.timeBarTarget.classList.add('animate-timer')
    }, 1000);
  }


}

// const bars = document.querySelectorAll(".round-time-bar");
// button.addEventListener("click", () => {
//   bars.forEach((bar) => {
//     bar.classList.remove("round-time-bar");
//     bar.offsetWidth;
//     bar.classList.add("round-time-bar");
//   });
// });
