import UIkit from "uikit";
window.addEventListener("load", (event) => {
    ["alert", "notice"].forEach(alert => {
        var alert = document.getElementById(alert);
        if(alert.textContent.length > 0)
            UIkit.notification({
                message: alert.textContent
            });
    })
});