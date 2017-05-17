#!/usr/bin/env ruby
require 'pry'
require_relative "../lib/api_communicator-2.rb"
require_relative "../lib/command_line_interface.rb"
#binding.pry
welcome
character = get_character_from_user
char = Search.new(character)
char.films
