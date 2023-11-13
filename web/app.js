/*================== DARK LIGHT THEME =================*/
const themeButton = document.getElementById('theme-button'),
darkTheme = 'dark-theme',
iconTheme = 'uil-sun';

const selectedTheme = localStorage.getItem('selected-theme');
const selectedIcon = localStorage.getItem('selected-icon');

const getCurrentTheme = () => document.body.classList.contains(darkTheme) ? 'dark' : 'light';
const getCurrentIcon = () => themeButton.classList.contains(iconTheme) ? 'uil-moon' : 'uil-sun';

if (selectedTheme) {
    document.body.classList[selectedTheme === 'dark' ? 'add' : 'remove'](darkTheme);
    themeButton.classList[selectedIcon === 'uil-moon' ? 'add' : 'remove'](iconTheme);
}

themeButton.addEventListener('click', () => {
    document.body.classList.toggle(darkTheme);
    themeButton.classList.toggle(iconTheme);

    localStorage.setItem('selected-theme', getCurrentTheme());
    localStorage.setItem('selected-icon', getCurrentIcon());
});

/*================== WINDOW SCROLL  =================*/
window.addEventListener('scroll', () => {
	const nav = document.querySelector('nav');
	
	window.scrollY >= 80 ? nav.classList.add('fixed') : nav.classList.remove('fixed');
});


//let addBtn = document.getElementById('addCat');
let newCat = document.querySelector('.gridDiez');



let html = `
		<input type="text" name="txtmedidas" placeholder="Medidas"/>

	`;
// Se cancela el boton para agregar nuevas medidas correctivas
//addBtn.addEventListener('click', (e) => {
//	
//	e.preventDefault();	
//	newCat.insertAdjacentHTML('beforeend', html);
//
//});