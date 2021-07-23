module Requester
  def option_main_menu
    puts "1. try again | 2. random | 3. save playlist | 4. exit"
    option = gets.chomp.to_i
    until [1,2,3,4].include? option
      puts "invalid into unless"
      puts "Invalid option"
      puts "1. try again | 2. random | 3. save playlist | 4. exit"
      option = gets.chomp.to_i
    end
    option
  end
end
