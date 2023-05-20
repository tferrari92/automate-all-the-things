src="resources/memes.js"

function getRandomImage() {
    var index = Math.floor(Math.random() * images.length);
    var image = images[index];
    var displayElement = document.getElementById("display");
    displayElement.src = image;
    displayElement.style.display = "block";
}

var memeButton = document.getElementById("memeButton");
memeButton.addEventListener("click", getRandomImage);
