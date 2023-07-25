import Rails from "@rails/ujs"
import UIkit from "uikit"

const BOTTOM = "#bottom-of-page"
const POST_CONTAINER = "#post-index"

export default {
    index: _ => {
        var oldest = new Date(Date.now()).toISOString()
        UIkit.util.on(POST_CONTAINER, 'inview', event => {
            Rails.$("title")[0].innerHTML = event.target.dataset.title
        });
        UIkit.util.on(BOTTOM, 'inview', _ => {
            Rails.ajax({
                url: "/posts.json",
                data: new URLSearchParams({'before': oldest}).toString(),
                type: "get",
                success: data => { 
                    console.log(data)
                    Rails.$(POST_CONTAINER)[0].innerHTML += data.html
                    oldest = data.oldest
                    if(data.count != data.limit) {
                        Rails.$(BOTTOM)[0].remove()
                    }
                },
                error: err => {
                    console.error(err)
                    Rails.$(BOTTOM)[0].remove()
                    Rails.$("#fetch-error")[0].className = ""
                }
            })
        });

        UIkit.scrollspy(Rails.$(BOTTOM)[0])
    }
}