const fileInput = document.getElementById('file-upload');
const fileLabel = document.querySelector('.file-label');
const imagePreview = document.getElementById('image-preview');
const buttonGroup = document.querySelector('.button-group');
const imgGroup = document.querySelector('.imgGroup');
const htmlSaveButton = '<button type="submit" class="btn btn-success">Save</button>';

const deleteButton = () => {
    const button = document.createElement('button');
    button.classList.add('btn-delete');
    button.classList.add('btn');
    button.classList.add('btn-danger');
    button.innerHTML = '<i class="fa-solid fa-trash"></i>Delete';
    return button;
}

const handleAddImg = (src) => {
    const imgPreview = document.cloneNode(true).querySelector('.preview');
    const img = imgPreview.querySelector("img");
    img.src = src;
    const deleteButtonNode = document.querySelector("#deleteButton");
    const deleteButtonFragment = deleteButtonNode.content.cloneNode(true);
    const deleteButtonElement = deleteButtonFragment.querySelector("div");
    imgPreview.setAttribute("id", `img${src.split("/").pop()}`);
    deleteButtonElement.addEventListener('click', () => {
        removeImg(imgPreview.id);
    });
    imgPreview.appendChild(deleteButtonElement);
    return imgPreview;
}

const removeImg = (imgID) => {
    const imgPreview = document.querySelector(`#${imgID}`);
    imgGroup.removeChild(imgPreview);
}


fileInput.addEventListener('change', () => {
    if (fileInput.files.length > 0) {
        const files = Array.from(fileInput.files);
        const srcs = files.map(file => URL.createObjectURL(file));
        srcs.forEach(element => {
            imgGroup.insertBefore(handleAddImg(element), document.querySelector('.preview'));
        });

    } else {
        imagePreview.src = '#';
        fileLabel.textContent = 'No file selected';
    }
});
