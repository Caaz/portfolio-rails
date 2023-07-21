import UIkit from "uikit";
import Icons from "uikit-icons";
import { createNoise2D } from 'simplex-noise';
import { Artist } from "classes/artist";
UIkit.use(Icons);
window.addEventListener("load", (event) => {
    // Set up Canvas
    const canvas = document.getElementById("hero-canvas");
    const noise2D = createNoise2D();
    const particles = []
    const particle_limit = 100;
    const noise_zoom = 10;
    const art = (artist) => {
        const {ctx, canvas, frame} = artist;
        ctx.fillStyle = "#6527BE";
        const center = {x:canvas.width/2, y:canvas.height/2};
        if (particles.length < particle_limit) {
            
            particles.push({
                x: center.x + noise2D(Math.random(), Math.random()) * 10,
                y: center.y + noise2D(Math.random(), Math.random()) * 10,
                life:particle_limit
            })
        }
        particles.forEach(particle => {
            var noise = noise2D(particle.x/noise_zoom, (particle.y+frame/10)/noise_zoom)
            particle.y += -2 + noise * 2 * Math.random();
            particle.x += 0 + noise * 5 * Math.random();
            particle.life -= 1;

            ctx.beginPath();
            ctx.arc(particle.x, particle.y, 2, 0, 2 * Math.PI);
            ctx.fill();
        })
        while(particles[0].life <= 0) {
            particles.shift()
        }
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