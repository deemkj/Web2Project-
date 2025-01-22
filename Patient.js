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