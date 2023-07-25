import ajax_content from "helpers/ajax_content"
export default {
    index: _ => {
        console.log("Projects loaded")
        ajax_content('/projects.json')
    }
}