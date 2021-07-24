require_relative "helpers/presenter"
require_relative "helpers/requester"
require_relative "services/token"
require_relative "services/playlist_service"
require_relative "services/recommend_services"

class SpotifyPlaylist
  include Presenter
  include Requester

  def initialize
    @token = ""
  end

  def start
    create_session
    puts welcome
    ramdom
    option = 0
    until option == 4
      option = option_main_menu.to_i
      case option
      when 1 then try_again
      when 2 then ramdom
      when 3 then puts "Save playlist"
      when 4 then puts "Exit"
      end
    end
  end

  def create_session
    @token = Services::Token.request_authorization[:access_token]
  end

  def obtain_list_genres
    genres_list = Services::PlaylistService.genres_list(@token)
    p genres_list[:genres] # gives you list of genres of spotify app
    genres_list[:genres].sample
  end

  # (gender)
  def obtain_list_songs(genres)
    recomend_list = Services::RecommendService.songs_list(@token.to_s, genres)[:tracks]
    # HARCODE
    artists = recomend_list.map { |a| a[:artists].map { |n| n[:name] } }
    titles = recomend_list.map { |a| a[:name] }
    duration = recomend_list.map { |a| seconds_to_hms(a[:duration_ms] / 1000) }
    (1..artists.length).map do |position|
      { title: titles[position - 1], artist: artists[position - 1].join(", "), duration: duration[position - 1] }
    end
  end

  def seconds_to_hms(sec)
    # "%02d:%02d:%02d" % [sec / 3600, sec / 60 % 60, sec % 60]
    "#{sec / 60 % 60}:#{sec % 60}"
  end

  def try_again
    show_table(obtain_list_songs(@genres))
  end

  def ramdom
    @genres = obtain_list_genres
    puts @genres.to_s
    puts "---------"
    show_table(obtain_list_songs(@genres))
  end
end

spotify_playlist = SpotifyPlaylist.new
spotify_playlist.start
