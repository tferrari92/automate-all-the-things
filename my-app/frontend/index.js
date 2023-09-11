src = "resources/memes.js";

function getRandomImage() {
  var index = Math.floor(Math.random() * images.length);
  var image = images[index];
  var displayElement = document.getElementById("display");
  displayElement.src = image;
  displayElement.style.display = "block";
}

var memeButton = document.getElementById("memeButton");
memeButton.addEventListener("click", getRandomImage);

async function fetchVisitorCount() {
  try {
    const response = await fetch('./api');
    if (!response.ok) {
      throw new Error("Request failed");
    }
    const data = await response.json();
    console.log(data);

    document.getElementById("visitorCount").textContent = `Visits: ${data.count}`;
  } catch (error) {
    console.error("Error:", error);
  }
}

fetchVisitorCount();
