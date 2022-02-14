class TicTacToe
  attr_accessor :board, :player1, :player2

  @@board = [[1, 2, 3],
             [4, 5, 6],
             [7, 8, 9]]
  @@board_keys = { 1 => [0, 0],
                   2 => [0, 1],
                   3 => [0, 2],
                   4 => [1, 0],
                   5 => [1, 1],
                   6 => [1, 2],
                   7 => [2, 0],
                   8 => [2, 1],
                   9 => [2, 2] }

  def initialize(player1, player2)
    @current_player = nil
    @player1 = player1
    @player2 = player2
  end

  def add_player(player)
    @players << player
    player.board = @board
  end

  def add_board
    @@board = @board
  end

  def display_board
    puts <<-HEREDOC
         #{@@board[0][0]} | #{@@board[0][1]} | #{@@board[0][2]}
        ---+---+---
         #{@@board[1][0]} | #{@@board[1][1]} | #{@@board[1][2]}
        ---+---+---
         #{@@board[2][0]} | #{@@board[2][1]} | #{@@board[2][2]}
    HEREDOC
  end

  def play
    current_player = player1

    loop do
      begin
        puts "#{current_player.name}, choose a number between 1-9 that is available on the board"
        display_board
        num = gets.chomp
        key = @@board_keys[num.to_i]
        raise "Position taken" if @@board[key[0]][key[1]].class == String
      rescue  Exception => e
        puts "#{e}, choose any other position that's currently unoccupied"
        retry
      else
        @@board[key[0]][key[1]] = current_player.icon
      end
      if game_over?
        display_board
        puts "#{current_player.name} wins the game!"
        break
      elsif board_full?
        puts "It's a draw!"
        break
      else
        current_player = switch_player(current_player)
      end
    end
  end

  def switch_player(current_player)
    if current_player == player1
      player2
    else
      player1
    end
  end

  def show_board
    @@board
  end

  def game_over?
    combos = []
    combos << @@board[0]
    combos << @@board[1]
    combos << @@board[2]
    combos << [@@board[0][0], @@board[1][0], @@board[2][0]]
    combos << [@@board[0][1], @@board[1][1], @@board[2][1]]
    combos << [@@board[0][2], @@board[1][2], @@board[2][2]]
    combos << [@@board[0][0], @@board[1][1], @@board[2][2]]
    combos << [@@board[0][2], @@board[1][1], @@board[2][0]]
    combos.any? { |combo| combo.uniq.length == 1 }
  end

  def board_full?
    @@board.flatten.all? { |item| item.instance_of?(String) }
  end
end

class Players
  attr_reader :name, :icon

  def initialize(name, icon)
    @name = name
    @icon = icon
  end
end

player1 = Players.new('Sam', 'x')
player2 = Players.new('Kate', 'o')

game = TicTacToe.new(player1, player2)
game.play
