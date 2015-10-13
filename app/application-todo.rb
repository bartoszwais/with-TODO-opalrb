class TODO
    def initialize
      list = Document.find('#list')
      form = Document.find('#form')
      text_box = form.find('input')

      form.on(:submit) do |event|
        event.prevent

        item = Element.new('div.row')
        item.html = "<div class='card'><p>#{text_box.value}</p></div>"
        item.on(:click) { item.remove }

        list.append(item)

        text_box.value = ''
      end
    end
end
