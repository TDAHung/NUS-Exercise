const btnActive = document.querySelectorAll(".btn.btn-outline-primary");
btnActive.forEach(element => {
    element.addEventListener("click", () => {
        document.querySelector(".btn.btn-outline-primary.active").classList.remove("active");
        element.classList.add("active");
    });
});

