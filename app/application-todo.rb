class TODO
    def initialize
        list = Document.find('#list')
        form = Document.find('#form')
        text_box = form.find('input')

        button_send_list_to_email = Element.new('button')
        button_send_list_to_email.add_class('send_email')
        button_send_list_to_email.html('send as email')
        button_send_list_to_email.on(:click) { |event|
            event.prevent
            puts 'TODO: send list entries in email'
        }
        list.append(button_send_list_to_email)

        Element.find('.dot').on(:click) { |event|
            event.prevent
            Element.find('.dot').animate({right: '80%'})
        }

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
