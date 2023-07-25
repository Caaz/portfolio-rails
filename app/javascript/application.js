
import "trix"
import "@rails/actiontext"

import UIkit from "uikit";
import Icons from "uikit-icons";

import application from "controllers/application"
import posts from "controllers/posts"
import projects from "controllers/projects"

UIkit.use(Icons);

window.addEventListener("load", (event) => {
    const controller = document.body.getAttribute("data-controller")
    const action = document.body.getAttribute("data-action")
    
    // Set up page specific js
    const controllers = { posts, application, projects }
    if (controllers.hasOwnProperty(controller) && controllers[controller].hasOwnProperty(action)) {
        controllers[controller][action]()
    }

    // Set up notifications
    ["alert", "notice"].forEach(alert => {
        var alert = document.getElementById(alert);
        if(alert.textContent.length > 0)
            UIkit.notification({
                message: alert.textContent
            });
    })
})