require_relative "helpers/presenter"
require_relative "helpers/requester"
require_relative "services/token"
require_relative "services/playlist_service"
require_relative "services/recommend_services"

class SpotifyPlaylist
  include Presenter
  include Requester

  def initialize(hours_travel)
    @token = ""
    @hours_travel = hours_travel.to_i#Store.new(filename) # create a class to save the data into a json #TASK OF EDER xD
  end

  def start
    create_session
    show_genres(obtain_list_genres)
    obtain_list_songs
    puts welcome
    option = 0
    until option == 5
      show_table(obtain_list_songs,@hours_travel)
      option = option_main_menu.to_i
      case option
      when 1 then puts "obtain_list_genres"
      when 2 then puts "Try again"
      when 3 then puts "Random"
      when 4 then puts "Save playlist"
      when 5 then puts "Exit"
      end
    end
  end

  def create_session
    @token = Services::Token.request_authorization[:access_token]
  end

  def obtain_list_genres
    genres_list = Services::PlaylistService.genres_list(@token)
    genres_list[:genres] # gives you list of genres of spotify app
  end

  # (gender)
  def obtain_list_songs
    recomend_list = Services::RecommendService.songs_list(@token.to_s, "rock")[:tracks]
    # HARCODE
      artists = recomend_list.map { |a| a[:artists].map { |n| n[:name] } }.flatten
      titles = recomend_list.map { |a| a[:name] }
      duration = recomend_list.map { |a| a[:duration_ms]}
    (1..artists.length).map do |position|
      { title: titles[position - 1], artist: artists[position - 1], duration: duration[position - 1] }
    end
  end


end

hours_travel = ARGV.empty? ? 1 : ARGV.shift

spotify_playlist = SpotifyPlaylist.new(hours_travel)
spotify_playlist.start

file.close

puts [
  "\n####################################",
  "#   Thanks for using Spotify App   #",
  "####################################\n\n"
]
