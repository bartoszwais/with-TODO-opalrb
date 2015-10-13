require 'opal'
require 'opal-jquery'
require_relative 'application-todo.rb'

class Content 
    def initialize
        content = Element.find('#content')
        active_dot = Element.new('div')
        active_dot.add_class 'dot'
        active_dot.html = 'Tap'

        content.append(active_dot)
    end
end
Document.ready? do
    Content.new
    TODO.new

end
