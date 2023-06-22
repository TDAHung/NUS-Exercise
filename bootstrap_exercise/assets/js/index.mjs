import { data } from "./sample.js";
const albumContent = document.querySelector(".main__album .row");

document.addEventListener("DOMContentLoaded", () => {
    const albumNode = document.querySelectorAll(".child-node");
    let string = '';
    albumNode.forEach(element => {
        const descriptionNode = element.querySelector(".photo__description");
        let string = descriptionNode.innerText;
        if (string.length > 150) {
            string = string.substring(0, 150) + '...';
        }
        descriptionNode.innerText = string;
    });
});

const handlePhotoAlbum = (parentElement, object) => {
    const albumChild = parentElement.querySelector(".photo");
    const albumSrc = albumChild.querySelector("img");
    albumSrc.src = object;
    return albumChild;
}

const handleShowAlbum = album => {
    const albumTemplate = document.querySelector("#template__button__album");
    const albumFragment = albumTemplate.content.cloneNode(true);
    const albumElement = albumFragment.querySelector("button");

    albumElement.querySelector(".photo__title").innerText = album.title;
    albumElement.querySelector(".photo__description").innerText = album.description;
    albumElement.querySelector(".photo__liked .text-primary").href = album.like;
    albumElement.querySelector(".photo__time").innerText = album.created_at;

    const albumWrapper = albumElement.querySelector(".photo__wrapper");
    album.photoSrc.forEach(element => {
        albumWrapper.appendChild(handlePhotoAlbum(albumElement.cloneNode(true), element));
    });
    return albumElement;
};

const init = () => {
    const activePage = document.querySelector('.page-link, .active');
    let i = 0;
    data.forEach(element => {
        albumContent.appendChild(handleShowAlbum(element));
        i++;
        if (i === 4) return;
    })
}

init();

const handleShowModal = carouselImgObject => {
    const carouselImgTemplate = document.querySelector("#template__carousel__img");
    const carouselImgFragment = carouselImgTemplate.content.cloneNode(true);
    const carouselImgElement = carouselImgFragment.querySelector("div");
    const img = carouselImgElement.querySelector("img");
    img.src = carouselImgObject.src;
    return carouselImgElement;
}

const buttonModal = document.querySelectorAll(".button-modal");
buttonModal.forEach(element => {
    element.addEventListener("click", () => {
        const modal = document.querySelector('#albumModal');
        modal.querySelector(".modal-title").innerText = element.querySelector(".photo__title").innerText;
        modal.querySelector(".modal-description").innerText = element.querySelector(".photo__description").innerText;
        const imgElement = element.querySelectorAll(".photo img");
        const carouselInner = modal.querySelector(".carousel-inner");
        imgElement.forEach(img => {
            carouselInner.appendChild(handleShowModal(img));
        });
        carouselInner.querySelector(".carousel-item").classList.add("active");
    });
});

const navbarResponsive = document.querySelector(".navbar-responsive");
const navbarNormal = document.querySelector(".navbar-normal");
navbarResponsive.addEventListener("click", () => {
    navbarNormal.classList.add("active");
    navbarResponsive.classList.add("d-none");
    console.log(navbarNormal);
});
