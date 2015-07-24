require_relative 'rover'
require_relative 'direction'
require_relative 'orientation'
require_relative 'command_processor'

command_processor = CommandProcessor.new({commands: File.read("data/input.txt")})
puts command_processor.execute_all
