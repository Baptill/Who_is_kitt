import gsap from "gsap"

const gameAnimation = () => {

  //const pendingScreen = document.querySelector(".pending-screen")

  const fightElement = document.querySelector(".fight");
  // Pending anim
  console.log(pendingScreen)

  if (pendingScreen) {
    gsap.from(fightElement, {
      duration: 1.0,
      delay: 1.0,
      scale: 8,
      opacity:0,
      ease: "bounce.out"
    })
    // setTimeout(() => {
    //   fightElement.style.display = "none"
    //   }, 3000);
  }
  // Critical anim
  if(document.querySelector(".critical")) {
    const pending = document.querySelector(".critical")

    gsap.from(pending, {
      delay: 0.5,
      duration: 1.0,
      scale: 10,
      opacity:0,
      ease:"power4.out",
      letterSpacing: 100
    })
    setTimeout(() => {
      pending.style.display = "none"
      }, 3000);

    pendingScreen.classList.add('critical-animation')
  }


  //Buzzer animation
  if(document.querySelector(".buzzer")) {
    const buzzer = document.querySelector(".critical")

    gsap.from(buzzer, {
      duration: 0.5,
      scale: 10,
      opacity:0,
      ease:"power4.out",
    })
    setTimeout(() => {
      buzzer.style.display = "none"
      }, 3000);
  }
}

export { gameAnimation }
