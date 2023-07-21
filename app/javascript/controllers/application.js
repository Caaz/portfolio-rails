import UIkit from "uikit";
import Icons from "uikit-icons";
import { Artist } from "classes/artist";
UIkit.use(Icons);
window.addEventListener("load", (event) => {
    // Set up Canvas
    const canvas = document.getElementById("hero-canvas");
    const art = (artist) => {
        const {ctx, canvas, frame} = artist;
        ctx.fillStyle = "#6527BE";
        var width = 100*Math.sin(frame/30);
        var height = 100*Math.sin(frame/30);
        ctx.fillRect(canvas.width/2-width/2, canvas.height/2-height/2, width, height);
    };
    const artist = new Artist(canvas, art);
    artist.begin()
    // Randomize tagline
    const taglines = document.querySelectorAll("#hero p");
    if (taglines.length > 0)
        taglines[Math.floor(Math.random()*taglines.length)].className = "";
    // Setup notifications
    ["alert", "notice"].forEach(alert => {
        var alert = document.getElementById(alert);
        console.log("Got an alert!", alert)
        if(alert.textContent.length > 0)
            UIkit.notification({
                message: alert.textContent
            });
    })
});