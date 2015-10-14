require 'opal'
require 'opal-jquery'
require_relative 'application-todo.rb'

class Content 
    def initialize
        content = Element.find('#content')
        active_dot = Element.new('div')
        active_dot.add_class 'dot'
        active_dot.html = 'Tap'

        active_dot.on(:click) { |event|
            event.prevent
            Element.find('.dot').animate({right: '80%'})
        }

        content.append(active_dot)
    end
end
Document.ready? do
    Content.new
    TODO.new

end
