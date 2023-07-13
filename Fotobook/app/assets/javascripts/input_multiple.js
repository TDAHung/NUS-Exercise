const fileInput = document.getElementById('file-upload');
const fileLabel = document.querySelector('.file-label');
const imagePreview = document.getElementById('image-preview');
const buttonGroup = document.querySelector('.button-group');
const imgGroup = document.querySelector('.imgGroup');
const htmlSaveButton = '<button type="submit" class="btn btn-success">Save</button>';
const dataGlobal = new DataTransfer();
const middleImgGroup = imgGroup.innerHTML;

const deleteButton = () => {
    const button = document.createElement('button');
    button.classList.add('btn-delete');
    button.classList.add('btn');
    return button;
}

const handleAddImg = (src, index) => {
    const imgPreview = document.cloneNode(true).querySelector('.preview');
    const img = imgPreview.querySelector("img");
    img.src = src;
    const deleteButtonNode = document.querySelector("#deleteButton");
    const deleteButtonFragment = deleteButtonNode.content.cloneNode(true);
    const deleteButtonElement = deleteButtonFragment.querySelector("div");
    imgPreview.setAttribute("id", `img${src.split("/").pop()}`);
    deleteButtonElement.addEventListener('click', () => {
        removeImg(imgPreview.id, index);
    });
    imgPreview.appendChild(deleteButtonElement);
    return imgPreview;
}

const removeImg = (imgID, index) => {
    const imgPreview = document.querySelector(`#${imgID}`);
    imgGroup.removeChild(imgPreview);
    const data = new DataTransfer();

    for (let i = 0; i < fileInput.files.length; i++) {
        const file = fileInput.files[i]
        if (index !== i)
            data.items.add(file)
    }
    fileInput.files = data.files;
    console.log(fileInput.files);
}

fileInput.addEventListener('change', () => {
    for (let i = 0; i < fileInput.files.length; i++) {
        const file = fileInput.files[i]
        dataGlobal.items.add(file)
    }
    fileInput.files = dataGlobal.files;
    console.log(fileInput.files, "asdasdad");

    if (fileInput.files.length > 0) {
        const files = Array.from(fileInput.files);
        const srcs = files.map(file => URL.createObjectURL(file));
        imgGroup.innerHTML = middleImgGroup;
        srcs.forEach((element, index) => {
            imgGroup.insertBefore(handleAddImg(element, index), document.querySelector('.preview'));
        });
    } else {
        imagePreview.src = '#';
        fileLabel.textContent = 'No file selected';
    }
});


document.addEventListener('DOMContentLoaded', () => {
    const albumDataTransfer = new DataTransfer();

    const previewImg = document.querySelectorAll('.photoUrl');
    previewImg.forEach(img => {
        fetch(img.value)
            .then(response => response.blob())
            .then(blob => {
                const fileName = img.value;
                const file = new File([blob], fileName);
                albumDataTransfer.items.add(file);
                fileInput.files = albumDataTransfer.files;
                console.log(fileInput.files);
            })
    })
})





