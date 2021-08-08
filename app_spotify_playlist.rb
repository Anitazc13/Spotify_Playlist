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
    @hours_travel = hours_travel.to_i # Store.new(filename)
    @song_list = []
    # create a class to save the data into a json
    # TASK OF EDER xD
  end

  def start
    create_session
    show_genres(obtain_list_genres)
    obtain_list_songs
    puts welcome
    option = 0
    until option == 5
      show_table(@song_list, @hours_travel)
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
    # p genres_list[:genres] # gives you list of genres of spotify app
    # genres_list[:genres].sample
    genres_list[:genres]
  end

  def obtain_list_songs(genres = "rock")
    recomend_list = Services::RecommendService.songs_list(@token.to_s, genres)[:tracks]
    @song_list = recomend_list.map do |track|
      song = {}
      song[:artist] = track[:artists].map { |n| n[:name] }.join(", ")
      song[:title] = track[:name]
      song[:duration] = track[:duration_ms]
      song[:uri] = track[:uri]
      song
    end
  end

  def seconds_to_hms(sec)
    # "%02d:%02d:%02d" % [sec / 3600, sec / 60 % 60, sec % 60]
    "#{sec / 60 % 60}:#{sec % 60}"
  end

  def try_again
    show_table(obtain_list_songs(@genres))
  end

  def random_genres
    @genres = obtain_list_genres
    puts @genres.to_s
    puts "---------"
    show_table(obtain_list_songs(@genres))
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
