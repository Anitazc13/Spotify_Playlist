module Requester
  def option_main_menu
    options = "1. Show genres | 2. try again | 3. random | 4. save playlist | 5. exit"
    puts options
    option = gets.chomp.to_i
    until [1, 2, 3, 4, 5 ].include? option
      puts "Invalid option"
      puts options
      option = gets.chomp.to_i
    end
    option
  end
end
