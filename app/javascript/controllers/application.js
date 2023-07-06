import UIkit from "uikit";
window.addEventListener("load", (event) => {
    // Set up Canvas
    const canvas = document.getElementById("hero-canvas");
    if (canvas === null) return;
    const ctx = canvas.getContext("2d");
    window.setInterval(() => {
        // ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.fillStyle = "#6527BE";
        if(canvas.height !== canvas.offsetHeight || canvas.width !== canvas.offsetWidth) {
            canvas.width = canvas.offsetWidth;
            canvas.height = canvas.offsetHeight;
        }
        ctx.fillRect(Math.random()*canvas.width, Math.random()*canvas.height, 10, 10);
    }, 1000 / 30);
    // Randomize tagline
    const taglines = document.querySelectorAll("#hero p");
    taglines[Math.floor(Math.random()*taglines.length)].className = "";
    // Setup notifications
    ["alert", "notice"].forEach(alert => {
        var alert = document.getElementById(alert);
        if(alert.textContent.length > 0)
            UIkit.notification({
                message: alert.textContent
            });
    })
});