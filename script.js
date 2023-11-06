const dynamicTextElement = document.getElementById("dynamic-text");
const texts = ["Key Stroker", "Data Enthusiast", "Opportunity Seeker"]; // Define the texts to cycle through
let currentIndex = 0;
let currentText = texts[currentIndex];
let charIndex = 0;
let isDeleting = false;

function updateDynamicText() {
    dynamicTextElement.textContent = currentText.substring(0, charIndex);

    if (isDeleting) {
        charIndex--;

        // When text is fully deleted, switch to the next text
        if (charIndex === 0) {
            currentIndex = (currentIndex + 1) % texts.length;
            currentText = texts[currentIndex];
            isDeleting = false;
        }
    } else {
        charIndex++;

        // When typing is complete, start deleting
        if (charIndex === currentText.length + 1) {
            isDeleting = true;
        }
    }

    const typingSpeed = isDeleting ? 50 : 200; // Adjust typing and deleting speed as needed

    setTimeout(updateDynamicText, typingSpeed);
}

// Call the function initially to start the effect
updateDynamicText();

