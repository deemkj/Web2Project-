function showForm(role) {

    document.getElementById('patient-form').classList.add('hidden');
    document.getElementById('doctor-form').classList.add('hidden');

    document.getElementById('P').style.color = '';
    document.getElementById('D').style.color = '';

    if (role === 'patient') {
        document.getElementById('patient-form').classList.remove('hidden');
        document.getElementById('P').style.color = '#f0be36';  

    } else if (role === 'doctor') {
        document.getElementById('doctor-form').classList.remove('hidden');
        document.getElementById('D').style.color = '#f0be36';  
    }
}

function showMore(button) {

    var hiddenRev = document.querySelectorAll('.cusRev.hidden'); 
    
    hiddenRev.forEach(function(cusRev) {
        cusRev.classList.remove('hidden'); 
    });

    if (document.querySelectorAll('.cusRev.hidden').length === 0) {
        button.style.display = 'none'; 
    }
}

document.addEventListener("DOMContentLoaded", function() {
    var heroImage = document.getElementById("hero-image");

    if (!heroImage) return; 

    var images = [
        "images/main2.jpg", 
        "images/main3.jpg", 
        "images/main4.jpg", 
    ];

    var currentImageIndex = 0;

    function changeImage() {
        heroImage.classList.add("fade-out");
        setTimeout(function() {
            currentImageIndex = (currentImageIndex + 1) % images.length;
            heroImage.src = images[currentImageIndex];
            heroImage.classList.remove("fade-out");
        }, 1000);
    }

    setInterval(changeImage, 3000);
});




document.addEventListener("DOMContentLoaded", () => {
    const cancelLinks = document.querySelectorAll(".cancel-link");

    cancelLinks.forEach(link => {
        link.addEventListener("click", (event) => {
            event.preventDefault();
            alert("Are you sure you want to cancel this appointment?");
            // Add functionality to handle cancellation here
        });
    });
});















const patients = {
    123: { name: "Leena Naser", age: 40, gender: "Female", medications: "Antibiotics" },
    124: { name: "Majed Saleh", age: 35, gender: "Male", medications: "N/A" }
};


const urlParams = new URLSearchParams(window.location.search);
const patientId = urlParams.get('patientId');

if (patientId && patients[patientId]) {
    const patient = patients[patientId];
    document.getElementById('name').value = patient.name;
    document.getElementById('age').value = patient.age;
    document.getElementById('gender').value = patient.gender;
    document.getElementById('currentMedications').value = patient.medications;
}


document.getElementById('prescribeForm').addEventListener('submit', (e) => {
    e.preventDefault();
    alert("Medication prescribed successfully!");
    window.location.href = "Doctor.html";
});


const cards = document.querySelectorAll('.medication-flashcard .card');
const tooltip = document.getElementById('tooltip');

cards.forEach(card => {
card.addEventListener('mouseenter', (e) => {
    const description = card.getAttribute('data-description');
    tooltip.textContent = description;
    tooltip.style.display = 'block';
    tooltip.style.left = `${e.pageX + 10}px`;
    tooltip.style.top = `${e.pageY + 10}px`;
    tooltip.style.opacity = 1;
});

card.addEventListener('mousemove', (e) => {
    tooltip.style.left = `${e.pageX + 10}px`;
    tooltip.style.top = `${e.pageY + 10}px`;
});

card.addEventListener('mouseleave', () => {
    tooltip.style.opacity = 0;
    tooltip.style.display = 'none';
});
});
