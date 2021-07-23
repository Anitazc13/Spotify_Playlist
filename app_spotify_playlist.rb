require_relative "helpers/presenter"
require_relative "helpers/requester"
require_relative "services/token"

class SpotifyPlaylist
  include Presenter
  include Requester

  def initialize
    @token = ""
  end

  def start
    create_session
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
end

spotify_playlist = SpotifyPlaylist.new
spotify_playlist.start
