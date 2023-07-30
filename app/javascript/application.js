
import "trix"
import "@rails/actiontext"

import Rails from "@rails/ujs"
import UIkit from "uikit";
import Icons from "uikit-icons";

import application from "controllers/application"
import posts from "controllers/posts"
import projects from "controllers/projects"
import contact_requests from "controllers/contact_requests"
import sessions from "controllers/sessions"

UIkit.use(Icons);

window.addEventListener("load", (event) => {
    const controller = document.body.getAttribute("data-controller")
    const action = document.body.getAttribute("data-action")
    
    // Set up page specific js
    const controllers = { posts, application, projects, contact_requests, sessions }
    if (controllers.hasOwnProperty(controller) && controllers[controller].hasOwnProperty(action)) {
        controllers[controller][action]()
    }

    // Set up notifications
    ["alert", "notice"].forEach(alert => {
        var alert = document.getElementById(alert);
        if(alert.textContent.length > 0)
            UIkit.notification({
                message: alert.textContent,
                status: alert.id == "alert" ? "danger" : "primary"
            });
    })

    const errors = Rails.$("#form-errors")[0]
    if(errors) {
        UIkit.scroll("body").scrollTo(errors)
    }
    const input_fields = Rails.$("input")
    input_fields.forEach(input => {
        var errors = input.getAttribute("data-errors")
        var name = input.getAttribute("data-name")
        if(errors) {
            var labels = document.createElement("div")
            labels.className = "uk-grid-small"
            labels.setAttribute("uk-grid", true)
            errors = JSON.parse(errors);
            errors.forEach(error => {
                var div = document.createElement("div")
                var label = document.createElement("span")
                label.className = "uk-label uk-label-danger"
                label.textContent = `${name} ${error}`
                div.appendChild(label)
                labels.appendChild(div)
            })
            input.parentElement.parentElement.appendChild(labels)
        }
    })
    const navigation = Rails.$("nav a")
    const offcanvas_nav = Rails.$("#offcanvas-nav")[0]
    navigation.forEach(link => {
        console.log(link)
        var link_mirror = document.createElement("a")
        link_mirror.className = "uk-flex uk-flex-between"
        var tooltip = link.getAttribute("uk-tooltip")
        if (!tooltip) return
        var span = document.createElement("span")
        span.setAttribute("uk-icon", link.getAttribute("uk-icon"))
        link_mirror.appendChild(span)

        link_mirror.appendChild(document.createTextNode(tooltip.split(/[:;]/)[1]))
        var attributes = ["uk-toggle", "href"]
        attributes.forEach(attribute => {
            var found_attribute = link.getAttribute(attribute)
            if (!found_attribute) return
            link_mirror.setAttribute(attribute, found_attribute)
        })
        console.log(link_mirror)

        var li = document.createElement("li")
        li.appendChild(link_mirror)
        offcanvas_nav.appendChild(li)
    })
})