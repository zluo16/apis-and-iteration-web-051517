def welcome
  puts "Welcome to the Star Wars API!"
end

def get_character_from_user
  puts "please enter a character"
  # use gets to capture the user's input. This method should return that input, downcased.
  character = gets.chomp
  character.downcase
end
