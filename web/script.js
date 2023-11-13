// Recuperamos los inputs del documento
const txtNombre = document.getElementById('txtnombre');
const txtAccidente = document.getElementById('txtaccidente');
const txtDeclaracion = document.getElementById('txtdeclaracion');
const chkRadios = document.querySelectorAll('.radios input');
const txtSupervisor = document.getElementById('txtsupervisor');
const txtDeclaracionSupervisor = document.getElementById('txtdeclaracionsupervisor');
const txtNombreTestigo = document.getElementById('txtnombretestigo');
const txtDeclaracionTestigo = document.getElementById('txtdeclaraciontestigo');
const txtDictamen = document.getElementById('txtdictamen');
const txtConclusiones = document.getElementById('txtconclusiones');
const chkRadioGolpes = document.querySelectorAll('.radio__flex .chkgolpe');
const txtMedidas = document.getElementById('txtmedidas');
const chkAnexos = document.querySelectorAll('.radio__flex .chkanexos');
const submitBtn = document.querySelector('.submit-btn');

let stepsSpan = document.querySelector('.steps p span');

document.addEventListener("DOMContentLoaded", function () {
    const steps = document.querySelectorAll(".step");
    let currentStep = 0;

    const nextButton = document.querySelector(".next-btn");
    const prevButton = document.querySelector(".prev-btn");
    const progressBar = document.querySelector(".progress");
    const totalSteps = steps.length;
    submitBtn.classList.add('disabled');
    stepsSpan.textContent = 1;
    submitBtn.style.display = 'none';
    
    if (currentStep === 0) {
        prevButton.style.display = "none";
    }

    steps.forEach((step, index) => {
        if (index !== currentStep) {
            step.style.display = "none";
        }
    });

    nextButton.addEventListener("click", function () {
        if (validarCampos()) { // Validar que los campos no esten vacios
            prevButton.style.display = "inline-block";
            if(currentStep === 3) {
                nextButton.style.display = "none";
                submitBtn.style.display = "inline-block";
            } else {
                nextButton.style.display = "inline-block";
            }
            if (currentStep < steps.length - 1) { // Avanzamos al siguiente paso
                steps[currentStep].style.display = "none";
                currentStep++;
                steps[currentStep].style.display = "block";
                updateProgressBar();
                stepsSpan.textContent = currentStep + 1;
            }
            if (currentStep === 3) {
               txtMedidas.addEventListener('input', actualizarEstadoBtnSubmit);
               chkAnexos.forEach(checkbox => checkbox.addEventListener('change', actualizarEstadoBtnSubmit));
            }
        } else { // alerta para cuando algun campo este vacio
            alert('Completa todos los campos antes de continuar');
        }
    });

    prevButton.addEventListener("click", function () {
        nextButton.style.display = "inline-block";
        if (currentStep !== 3) {
            submitBtn.style.display = "none";
        }
        if(currentStep === 1) {
            prevButton.style.display = 'none';
        }
        if (currentStep > 0) {
            steps[currentStep].style.display = "none";
            currentStep--;
            steps[currentStep].style.display = "block";
            updateProgressBar();
            stepsSpan.textContent = currentStep + 1;
        }
    });  

    function updateProgressBar() {
        const progressWidth = ((currentStep + 1) / totalSteps) * 100;
        progressBar.style.width = `${progressWidth}%`;
    }
    
    updateProgressBar();
    
    // Funcion para validar campos
    function validarCampos() {
        switch(currentStep) {
            case 0: 
                return txtNombre.value.trim() !== '' && txtAccidente.value.trim() !== '' && txtDeclaracion.value.trim() !== '';
            break;
            case 1: 
                const radioSelected = Array.from(chkRadios).some(checkbox => checkbox.checked);
                return txtSupervisor.value.trim() !== '' && txtDeclaracionSupervisor.value.trim() !== '' && radioSelected;
            break;
            case 2: 
                return txtNombreTestigo.value.trim() !== '' && txtDeclaracionTestigo.value.trim() !== '' && txtDictamen.value.trim() !== '' && txtConclusiones.value.trim() !== '';
            break;
            case 3:
                const radiosGolpes = Array.from(chkRadioGolpes).some(checkbox => checkbox.checked);
                return radiosGolpes;
            break;
        }
    }
    
    // Funcion para actualizar estado del boton submit
    function actualizarEstadoBtnSubmit() {
        const medidas = txtMedidas.value.trim() !== '';
        const radioAnexo = Array.from(chkAnexos).some(checkbox => checkbox.checked);
        
        if (medidas && radioAnexo) {
            submitBtn.classList.remove('disabled');
        } else {
            submitBtn.classList.add('disabled');
        }
    }
});