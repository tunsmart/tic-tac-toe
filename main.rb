class TicTacToe
  attr_accessor :board, :player1, :player2

  @@board = [[nil, nil, nil],
              [nil, nil, nil],
              [nil, nil, nil]]
  @@board_keys = {1=>[0,0],
                 2=>[0,1],
                 3=>[0,2],
                 4=>[1,0],
                 5=>[1,1],
                 6=>[1,2],
                 7=>[2,0],
                 8=>[2,1],
                 9=>[2,2]}

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

  def show_players
    puts player1.name
    puts player2.name
  end

  def play
    current_player = player1

    loop do
        puts "#{current_player.name}, choose a number between 1-9"
        num = gets.chomp
        key = @@board_keys[num]
        @@board[key[0]][key[1]] = current_player.icon
        if game_over?
            puts "#{current_player.name} wins the game!"
            break
        elsif board_full?
            puts "It's a draw!"
            break
        else
            switch_player(current_player)
        end
    end
    
  end

  def switch_player(current_player)
    if current_player == player1
        current_player = player2
    else
        current_player = player1
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
    combos << [@@board[0][0],@@board[1][0], @@board[2][0]]
    combos << [@@board[0][1],@@board[1][1], @@board[2][1]]
    combos << [@@board[0][2],@@board[1][2], @@board[2][2]]
    combos << [@@board[0][0],@@board[1][1], @@board[2][2]]
    combos << [@@board[0][2],@@board[1][1], @@board[2][0]]
    combos.any?{|combo| combo.uniq.length == 1}
  end

  def board_full?
    @@board.flatten.all?
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