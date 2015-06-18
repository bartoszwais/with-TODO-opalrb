require 'opal'
require 'opal-jquery'

Document.ready? do
  list, form = Document.find('#list'), Document.find('#form')
  text_box = form.find('input')

  form.on(:submit) do |event|
    event.prevent

    item = Element.new('li')
    item.text = text_box.value
    item.on(:click) { item.remove }

    text_box.value = ''

    list.append(item)
  end
end
