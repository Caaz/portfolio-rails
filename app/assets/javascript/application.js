//= require uikit/dist/js/uikit
//= require uikit/dist/js/uikit-icons



window.addEventListener("load", (event) => {
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
});