import Rails from "@rails/ujs"
import UIkit from "uikit"

export default {
    index: _ => {
        var oldest = new Date(Date.now()).toISOString()
        UIkit.util.on('#bottom-of-page', 'inview', _ => {
            Rails.ajax({
                url: "/posts.json",
                data: new URLSearchParams({'before': oldest}).toString(),
                type: "get",
                success: data => { 
                    console.log(data)
                    Rails.$("#post-index")[0].innerHTML += data.html
                    oldest = data.oldest
                    if(data.count != data.limit) {
                        Rails.$("#bottom-of-page")[0].remove()
                    }
                },
                error: err => {
                    console.error(err)
                }
            })
        });
    }
}