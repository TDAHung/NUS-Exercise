const fileInput = document.getElementById('file-upload');
const fileLabel = document.querySelector('.file-label');
const imagePreview = document.getElementById('image-preview');
const buttonGroup = document.querySelector('.button-group');
const htmlSaveButton = '<button type="submit" class="btn btn-success">Save</button>';

const deleteButton = () => {
    const button = document.createElement('button');
    button.classList.add('btn-delete');
    button.classList.add('btn');
    button.classList.add('btn-danger');
    button.innerHTML = '<i class="fa-solid fa-trash"></i>Delete';
    return button;
}

fileInput.addEventListener('change', () => {
    if (fileInput.files.length > 0) {
        const reader = new FileReader();
        reader.onload = () => {
            imagePreview.src = reader.result;
        };
        reader.readAsDataURL(fileInput.files[0]);

        const deleteButtonNode = deleteButton();
        buttonGroup.appendChild(deleteButtonNode);
        deleteButtonNode.addEventListener('click', () => {
            fileInput.value = '';
            imagePreview.src = '../../assets/images/camera.png';
            buttonGroup.innerHTML = htmlSaveButton;
        });
    } else {
        imagePreview.src = '#';
        fileLabel.textContent = 'No file selected';
    }
});
