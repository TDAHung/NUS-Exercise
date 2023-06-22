const fileInput = document.getElementById('avatar');
const fileLabel = document.querySelector('.file-label');
const imagePreview = document.querySelector('.form__img img');
console.log(imagePreview);

fileInput.addEventListener('change', () => {
    if (fileInput.files.length > 0) {
        const reader = new FileReader();
        reader.onload = () => {
            imagePreview.src = reader.result;
        };
        reader.readAsDataURL(fileInput.files[0]);

    } else {
        imagePreview.src = '#';
        fileLabel.textContent = 'No file selected';
    }
});
