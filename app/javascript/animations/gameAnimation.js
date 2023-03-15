import gsap from "gsap"

const gameAnimation = () => {

  const pendingScreen = document.querySelector(".pending-screen")
  // Pending anim
  if (pendingScreen) {
    gsap.from(".fight", {
      duration: 1.0,
      scale: 8,
      opacity:0,
      ease: "bounce.out"
    })
  }
  // Critical anim
  if(document.querySelector(".critical")) {
    const pending = document.querySelector(".critical")

    gsap.from(pending, {
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


  // //Buzzer animation
  // if(document.querySelector(".buzzer")) {
  //   const buzzer = document.querySelector(".critical")

  //   gsap.from(buzzer, {
  //     duration: 1.0,
  //     scale: 10,
  //     opacity:0,
  //     ease:"power4.out",
  //   })
  //   setTimeout(() => {
  //     buzzer.style.display = "none"
  //     }, 3000);
  // }
}

export { gameAnimation }
