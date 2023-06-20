(() => {
    const forms = document.querySelectorAll('.needs-validation');
    console.log(forms);
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            event.preventDefault();
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');
        }, false);
    })
})()
