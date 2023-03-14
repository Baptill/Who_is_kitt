import gsap from "gsap"

const criticalAnimation = () => {

  const critical = document.querySelector(".critical-animation")

  if (critical) {
    const critical = document.querySelector(".critical")
    gsap.from(critical, {
      duration: 0.5,
      scale: 10,
    })

    setTimeout(() => {
      critical.style.display = "none"
      }, 3000);
  }
}

export { criticalAnimation }
