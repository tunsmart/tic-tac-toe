require_relative 'players'
require_relative 'tictactoe'

puts "Welcome to TicTacToe Player 1\n"
puts "What's your name"
player1_name = gets.chomp
puts "\nWelcome #{player1_name}, What would you like your icon on the board to be. Choose any letter from a-z\n"
player1_icon = gets.chomp

puts "Welcome to TicTacToe Player 2\n"
puts "What's your name"
player2_name = gets.chomp
puts "\nWelcome #{player2_name}, What would you like your icon on the board to be.
    Choose any letter from a-z that is not #{player1_icon} \n"
begin
  icon = gets.chomp
  raise "icon already chosen by #{player1_name}, your opponent" if icon.downcase == player1_icon.downcase
rescue  Exception => e
  puts "#{e}, choose another letter"
  retry
else
  player2_icon = icon
end

player1 = Players.new(player1_name, player1_icon)
player2 = Players.new(player2_name, player2_icon)

game = TicTacToe.new(player1, player2)
game.play
