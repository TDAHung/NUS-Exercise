(() => {
    const forms = document.querySelectorAll('.needs-validation');
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            event.preventDefault();
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            const confirmPassword = document.querySelector("#passwordConfirm");
            const password = document.querySelector("#password");
            if (confirmPassword.value !== password.value) {
                document.querySelector(".valid-feedback.need-confirm").style.display = "none";
                document.querySelector(".invalid-feedback.need-confirm").innerText = "Need to be confirmed password";
            }

            form.classList.add('was-validated');

        }, false);
    })
})()
