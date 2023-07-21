import UIkit from "uikit";
import Icons from "uikit-icons";
import { createNoise2D } from 'simplex-noise';
import { Artist } from "classes/artist";
UIkit.use(Icons);
window.addEventListener("load", (event) => {
    // Set up Canvas
    const canvas = document.getElementById("hero-canvas");
    let angle = 0;
    
    // Define callback (which will be called 30 frames a second due to the Artist class)
    const art = (artist) => {
        const {ctx, canvas} = artist
        ctx.strokeStyle = "#6527BE";
        ctx.lineWidth = 5;
        ctx.lineJoin = "round";
        const centerX = canvas.width / 2;
        const centerY = canvas.height / 2;
        // Clear canvas
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        
        // Set rotation angle
        angle += 0.01;
        
        // Draw cube
        const size = 1;
        const vertices = [
            { x: -size, y: -size, z: -size },
            { x: size, y: -size, z: -size },
            { x: size, y: size, z: -size },
            { x: -size, y: size, z: -size },
            { x: -size, y: -size, z: size },
            { x: size, y: -size, z: size },
            { x: size, y: size, z: size },
            { x: -size, y: size, z: size }
        ];
        const projection = [];
        for (let i = 0; i < vertices.length; i++) {
            const vertex = vertices[i];
            const y = vertex.x;
            const x = vertex.y * Math.cos(angle) - vertex.z * Math.sin(angle);
            const z = vertex.y * Math.sin(angle) + vertex.z * Math.cos(angle) + size * 4;
            const d = 1 / (z / 300);
            const projectedX = x * d + centerX;
            const projectedY = y * d + centerY;
            projection.push({ x: projectedX, y: projectedY });
        }
        ctx.beginPath();
        ctx.moveTo(projection[0].x, projection[0].y);
        ctx.lineTo(projection[1].x, projection[1].y);
        ctx.lineTo(projection[2].x, projection[2].y);
        ctx.lineTo(projection[3].x, projection[3].y);
        ctx.lineTo(projection[0].x, projection[0].y);
        ctx.lineTo(projection[4].x, projection[4].y);
        ctx.lineTo(projection[5].x, projection[5].y);
        ctx.lineTo(projection[6].x, projection[6].y);
        ctx.lineTo(projection[7].x, projection[7].y);
        ctx.lineTo(projection[4].x, projection[4].y);
        ctx.moveTo(projection[1].x, projection[1].y);
        ctx.lineTo(projection[5].x, projection[5].y);
        ctx.moveTo(projection[2].x, projection[2].y);
        ctx.lineTo(projection[6].x, projection[6].y);
        ctx.moveTo(projection[3].x, projection[3].y);
        ctx.lineTo(projection[7].x, projection[7].y);
        ctx.stroke();
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