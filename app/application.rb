require 'opal'
require 'opal-jquery'
require_relative 'application-todo.rb'

Document.ready? do
    TODO.new
end
