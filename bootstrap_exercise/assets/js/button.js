const btnActive = document.querySelectorAll(".btn.btn-outline-primary");
btnActive.forEach(element => {
    element.addEventListener("click", () => {
        document.querySelector(".btn.btn-outline-primary.active").classList.remove("active");
        element.classList.add("active");
    });
});

document.addEventListener('DOMContentLoaded', () => {
    const prevPage = document.querySelector("#prev-button");
    const nextPage = document.querySelector("#next-button");
    const childNode = document.querySelectorAll('.child-node');
    const paginatedNumber = document.querySelector('.pagination');
    const pageLimit = 4;
    const pageCount = Math.ceil(childNode.length / pageLimit);
    let currentPage = 1;

    const disableButton = (button) => {
        button.classList.add("disabled");
        button.setAttribute("disabled", true);
    };

    const enableButton = (button) => {
        button.classList.remove("disabled");
        button.removeAttribute("disabled");
    };

    const handlePageButtonsStatus = () => {
        if (currentPage === 1) {
            disableButton(prevPage);
        } else {
            enableButton(prevPage);
        }

        if (pageCount === currentPage) {
            disableButton(nextPage);
        } else {
            enableButton(nextPage);
        }
    };

    const handleActivePageNumber = () => {
        document.querySelectorAll(".pagination-number").forEach((button) => {
            button.classList.remove("active");
            const pageIndex = Number(button.getAttribute("page-index"));
            if (pageIndex == currentPage) {
                button.classList.add("active");
            }
        });
    };

    const appendPageNumber = (index) => {
        const pageNumber = document.createElement("button");
        const pageNumberWrapper = document.createElement("li");
        pageNumberWrapper.className = "page-item";
        pageNumber.className = "pagination-number";
        pageNumber.classList.add("page-link");
        pageNumber.innerHTML = index;
        pageNumber.setAttribute("page-index", index);
        pageNumberWrapper.appendChild(pageNumber);
        const lastChild = paginatedNumber.querySelector(".page-item:last-child");
        paginatedNumber.insertBefore(pageNumberWrapper, lastChild);
    };

    const getPaginationNumbers = () => {
        for (let i = 1; i <= pageCount; i++) {
            appendPageNumber(i);
        }
    };

    const setCurrentPage = (pageNum) => {
        currentPage = pageNum;
        handleActivePageNumber();
        handlePageButtonsStatus();
        const prevRange = (pageNum - 1) * pageLimit;
        const currRange = pageNum * pageLimit;

        childNode.forEach((item, index) => {
            item.classList.add("d-none");
            if (index >= prevRange && index < currRange) {
                item.classList.remove("d-none");
            }
        });
    };

    window.addEventListener("load", () => {
        getPaginationNumbers();
        setCurrentPage(1);

        prevPage.addEventListener("click", () => {
            setCurrentPage(currentPage - 1);
        });

        nextPage.addEventListener("click", () => {
            setCurrentPage(currentPage + 1);
        });

        document.querySelectorAll(".pagination-number").forEach((button) => {
            const pageIndex = Number(button.getAttribute("page-index"));

            if (pageIndex) {
                button.addEventListener("click", () => {
                    setCurrentPage(pageIndex);
                });
            }
        });
    });
});
