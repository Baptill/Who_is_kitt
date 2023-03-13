import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="game-logic"
export default class extends Controller {
  static targets = ["timeBar", "timer"]

  connect() {

    var cpt = 30;

    timer = setInterval(function(){
        if(cpt>0) // si on a pas encore atteint la fin
        {
            --cpt; // décrémente le compteur
            var Crono = document.getElementById("timer"); // récupère l'id
            var old_contenu = Crono.firstChild; // stock l'ancien contenu
            Crono.removeChild(old_contenu); // supprime le contenu
            var texte = document.createTextNode(cpt); // crée le texte
            Crono.appendChild(texte); // l'affiche
        }
        else // sinon brise la boucle
        {
            clearInterval(timer);
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
