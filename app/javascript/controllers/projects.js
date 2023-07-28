import ajax_content from "helpers/ajax_content"
export default {
    index: _ => {
        ajax_content('/projects.json')
    }
}