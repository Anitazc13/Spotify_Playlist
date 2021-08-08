require "terminal-table"
module Presenter
  def welcome
    [
      "#" * 35,
      "Welcome to Spotify Playlist",
      "#" * 35
    ]
  end

  def seconds_to_hms(sec)
    # "%02d:%02d:%02d" % [sec / 3600, sec / 60 % 60, sec % 60]
    "#{sec / 60 % 60}:#{sec % 60}"
  end

  def show_genres(genre_list)
    list = (0..13).to_a
    table = Terminal::Table.new
    table.title = "Spotify Playlist Genres"
    table.rows = list.map{|i| ["#{i}. #{genre_list[i].capitalize}", "#{i+1*14}. #{genre_list[i+1*14].capitalize}",
                          "#{i+1*14*2}. #{genre_list[i+1*14*2].capitalize}","#{i+1*14*3}. #{genre_list[i+1*14*3].capitalize}",
                          "#{i+1*14*4}. #{genre_list[i+1*14*4].capitalize}","#{i+1*14*5}. #{genre_list[i+1*14*5].capitalize}",
                          "#{i+1*14*6}. #{genre_list[i+1*14*6].capitalize}","#{i+1*14*7}. #{genre_list[i+1*14*7].capitalize}",
                          "#{i+1*14*8}. #{genre_list[i+1*14*8].capitalize}"                
    ]}
    puts table
  end

  def show_table(song_list_before, hours_travel)
    seconds_travel = hours_travel.to_i * 3600000 
    seconds_should_be = 0
    song_list = []
    song_list_before.each do |item|
      seconds_should_be+= item[:duration]
      song_list <<  item if seconds_should_be <=seconds_travel
    end
    p song_list.size
    table = Terminal::Table.new
    table.title = "Spotify Playlist Generator"
    table.headings = %w[Song-Title Artist Duration]
    table.rows = song_list.map { |item| [item[:title], item[:artist], seconds_to_hms(item[:duration] / 1000) ] }
    puts table
  end
end
