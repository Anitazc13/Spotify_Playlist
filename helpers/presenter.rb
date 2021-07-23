require "terminal-table"
module Presenter
  def welcome
    [
      "#" * 35,
      "Welcome to Spotify Playlist",
      "#" * 35
    ]
  end

  def show_table(song_list)
    table = Terminal::Table.new
    table.title = "Spotify Playlist Generator"
    table.headings = %w[Song-Title Artist Duration]
    table.rows = song_list.map { |item| [item[:title], item[:artis], item[:duration]] }
    puts table
  end
end
