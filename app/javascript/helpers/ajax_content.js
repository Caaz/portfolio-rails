
import Rails from "@rails/ujs";
import UIkit from "uikit";

function ajax_content(endpoint, bottomSelector='#bottom', postContainerSelector='#index', errorSelector='#error') {
    var bottom = Rails.$(bottomSelector)[0]
    var postContainer = Rails.$(postContainerSelector)[0]
    var error = Rails.$(errorSelector)[0]
    var oldest = new Date(Date.now()).toISOString();
    UIkit.util.on(bottomSelector, 'inview', _ => {
        Rails.ajax({
        url: endpoint,
        data: new URLSearchParams({ 'before': oldest }).toString(),
        type: "get",
        success: data => {
            console.log(data)
            postContainer.innerHTML += data.html;
            oldest = data.oldest;
            if (data.count != data.limit)
                bottom.remove()
        },
        error: err => {
            console.error(err)
            bottom.remove()
            error.className = ""
        }
        });
    });

    UIkit.scrollspy(bottom);
}

export default ajax_content;