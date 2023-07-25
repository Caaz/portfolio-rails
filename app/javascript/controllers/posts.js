import Rails from "@rails/ujs"
import UIkit from "uikit"
import ajax_content from "helpers/ajax_content"


export default {
    index: _ => {
        ajax_content('/posts.json')
        UIkit.util.on('#index', 'inview', event => {
            Rails.$("title")[0].innerHTML = event.target.dataset.title
        });
    }
}