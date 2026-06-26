const navToggle = document.querySelector(".nav-toggle");
const navMenu = document.querySelector("#nav-menu");

if (navToggle && navMenu) {
  navToggle.addEventListener("click", () => {
    const isOpen = navToggle.getAttribute("aria-expanded") === "true";
    navToggle.setAttribute("aria-expanded", String(!isOpen));
    navMenu.classList.toggle("is-open", !isOpen);
  });

  navMenu.querySelectorAll("a").forEach((link) => {
    link.addEventListener("click", () => {
      navToggle.setAttribute("aria-expanded", "false");
      navMenu.classList.remove("is-open");
    });
  });
}

const ctaForm = document.querySelector(".cta-form");

if (ctaForm) {
  ctaForm.addEventListener("submit", (event) => {
    event.preventDefault();
    const emailInput = ctaForm.querySelector("#email");
    const email = emailInput instanceof HTMLInputElement ? emailInput.value.trim() : "";

    if (!email) {
      return;
    }

    ctaForm.reset();
    alert("Thanks! We'll be in touch soon.");
  });
}
