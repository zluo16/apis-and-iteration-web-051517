require 'rest-client'
require 'json'
require 'pry'

class Search

  attr_accessor :character, :films_arr, :character_hash
  attr_reader :films

  def initialize(character)
    @character = character
    @films_arr = get_character_movies_from_api
  end

  def films
    
    list = Array.new
    @films_arr.each do |url|
      info = RestClient.get(url)
      film_hash = JSON.parse(info)
      list << film_hash["title"]
    end

    list.each{|el| puts "#{list.index(el)+1} #{el}"}

  end

  private

  def get_character_movies_from_api
    character_arr = get_info
    film_list = Array.new

    character_arr.each do |char|
      if @character == char["name"].downcase
        char["films"].each{|url| film_list << url}
      end
    end
    film_list
  end

  def get_info
    num = 1
    all = Array.new
    while num < 10
      all_characters = RestClient.get("http://www.swapi.co/api/people/?page=#{num}")
      @character_hash = JSON.parse(all_characters)
      all.concat(@character_hash["results"])
      num += 1
    end
    all
  end

end

# def get_character_movies_from_api(character)
#   #make the web request
#   character_hash = get_info
#   film_list = Array.new
#
#   # iterate over the character hash to find the collection of `films` for the given
#   #   `character`
#   # collect those film API urls, make a web request to each URL to get the info
#   #  for that film
#   # return value of this method should be collection of info about each film.
#   #  i.e. an array of hashes in which each hash reps a given film
#   # this collection will be the argument given to `parse_character_movies`
#   #  and that method will do some nice presentation stuff: puts out a list
#   #  of movies by title. play around with puts out other info about a given film.
#
#   character_hash.each do |char|
#     if character == char["name"].downcase
#       char["films"].each{|url| film_list << url}
#     end
#   end
#   film_list
# end
#
# def get_info
#   num = 1
#   all = Array.new
#   while num < 10
#     all_characters = RestClient.get("http://www.swapi.co/api/people/?page=#{num}")
#     character_hash = JSON.parse(all_characters)
#     all.concat(character_hash["results"])
#     num += 1
#   end
#   all
# end
#
# def parse_character_movies(films_hash)
#   # some iteration magic and puts out the movies in a nice list
#   films_hash.each do |url|
#     info = RestClient.get(url)
#     film_hash = JSON.parse(info)
#     puts "#{films_hash.index(url)+1} #{film_hash["title"]}"
#   end
# end
#
# def show_character_movies(character)
#   films_hash = get_character_movies_from_api(character)
#   parse_character_movies(films_hash)
# end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
