require_relative "helpers/presenter"
require_relative "helpers/requester"
require_relative "services/token"
require_relative "services/playlist_service"

class SpotifyPlaylist
  include Presenter
  include Requester

  def initialize
    @token = ""
  end

  def start
    create_session
    obtain_list_recommendations
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

  def obtain_list_recommendations
    genres_list = Services::PlaylistService.genres_list(@token)
    # "BQCrmvI5-MXf-cP0Giu6zu9qZ2njhtsqQUOhq_N0VFU-KGGZDWdHsf8I5GNjFVLkpevrJMjG4HmhY_vnp1k")
    # genres_list[:genres].class #ARRAY
    p genres_list[:genres] #gives you list of genres of spotify app
  end


end

spotify_playlist = SpotifyPlaylist.new
#spotify_playlist.start
spotify_playlist.start
