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
    obtain_list_genres
    p obtain_list_songs
    puts welcome
    option = option_main_menu.to_i
    case option
    when 1 then puts "Try again"
    when 2 then puts "Random"
    when 3 then puts "Save playlist"
    when 4 then puts "Exit"
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
    duration = recomend_list.map { |a| seconds_to_hms(a[:duration_ms] / 1000) }
    (1..artists.length).map do |position|
      { title: titles[position - 1], artist: artists[position - 1], duration: duration[position - 1] }
    end
  end

  def seconds_to_hms(sec)
    # "%02d:%02d:%02d" % [sec / 3600, sec / 60 % 60, sec % 60]
    # format("%<min>02d:%<seg>02d", min = sec / 60 % 60, seg = sec % 60)
    # "%02d:%02d" % [sec / 3600, sec / 60 % 60, sec % 60]
    "#{sec / 60 % 60}:#{sec % 60}"
  end
end

spotify_playlist = SpotifyPlaylist.new
# spotify_playlist.start
spotify_playlist.start
