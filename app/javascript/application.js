
import "trix"
import "@rails/actiontext"

import UIkit from "uikit";
import Icons from "uikit-icons";

import application from "controllers/application"
import posts from "controllers/posts"

UIkit.use(Icons);

window.addEventListener("load", (event) => {
    const controller = document.body.getAttribute("data-controller")
    const action = document.body.getAttribute("data-action")
    
    // Set up page specific js
    const controllers = { posts, application }
    try { controllers[controller][action]() }
    catch (error) { }

    // Set up notifications
    ["alert", "notice"].forEach(alert => {
        var alert = document.getElementById(alert);
        if(alert.textContent.length > 0)
            UIkit.notification({
                message: alert.textContent
            });
    })
})