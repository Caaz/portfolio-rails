ActionView::Base.field_error_proc = proc do |html, instance|
    # puts a.object.errors.inspect
    # puts @object.inspect
    frag = Nokogiri::HTML5::DocumentFragment.parse(html)
    input = frag.children[0]
    input['class'] = [input['class'], 'uk-form-danger'].join(' ')
    input['data-errors'] = instance.error_message
    input['data-name'] = instance.instance_variable_get("@method_name")

    frag.to_html.html_safe
end