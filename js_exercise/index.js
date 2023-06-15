const calculatorbtn = document.querySelectorAll('.calculate-btns');
const resultText = document.querySelector('#result');
let result = '';
const errors = ["Math Error", "Syntax Error",];

const setValue = (text) => {
    result = text;
    resultText.value = result;
}

calculatorbtn.forEach(element => {
    element.addEventListener('click', () => {
        const btnvalue = element.value;
        if (errors.includes(resultText.value)) {
            result = btnvalue;
        }
        else {
            result += btnvalue;
        }
        resultText.value = result;
    });
});

const deleteOne = document.querySelector('#deleteOne');
deleteOne.addEventListener('click', () => {
    if (errors.includes(resultText.value)) setValue('');
    else setValue(resultText.value.substring(0, resultText.value.length - 1));
});

const deleteAll = document.querySelector('#deleteAll');
deleteAll.addEventListener('click', () => {
    setValue('');
});

const equalBtn = document.querySelector('#equal');
equalBtn.addEventListener('click', () => {
    try {
        result = eval(resultText.value);
        if (result === Infinity || result === -Infinity) resultText.value = 'Math Error';
        else resultText.value = result;
    } catch (error) {
        resultText.value = "Syntax Error";
    }
})
