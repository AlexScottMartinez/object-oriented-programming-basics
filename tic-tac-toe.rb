class Player
  # attribute reader methods
  attr_reader :marker, :name

  # using instance variables to being able to use these later on
  def initialize(tictactoe, marker, name)
    @tictactoe = tictactoe
    @marker = marker
    @name = name
  end

  # method where in in then command line it will ask the player to choose a position,
  #   and will continue to ask until the player enters an available position.
  def choose_position
    loop do
      puts "#{@name}, choose a number from the available positions:"
      position_choosen = gets.chomp.to_i
      if @tictactoe.available_positions.include?(position_choosen)
        return position_choosen
      end
      puts "\nInvalid input."
    end
  end
end

class TicTacToe
  # constant for the different ways to win tic-tac-toe
  WIN_COMBINATIONS = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 5, 9],
    [3, 5, 7],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9]
  ]
  # attribute reader method
  attr_reader :available_positions

  # using instance variables to being able to use these later on
  def initialize
    @players = [
      Player.new(self, 'X', 'Player 1'),
      Player.new(self, 'O', 'Player 2')
    ]
    @current_player = @players[0]
    @board = %w[1 2 3 4 5 6 7 8 9]
    @available_positions = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  # method that is the main one which calls the others, holds the code that
  #   prints the output to the terminal.
  def play
    puts "\nWelcome to Tic Tac Toe game!\n"
    sleep(2)
    loop do
      puts "\nGame board:"
      print_board
      sleep(0.5)
      position_choosen = @current_player.choose_position
      update_avaivalbe_positions(position_choosen)
      @board[position_choosen - 1] = @current_player.marker

      if winner?(@current_player)
        print_board
        sleep(0.5)
        puts "The winner is #{@current_player.name}!"
        play_again?
      elsif draw?
        print_board
        sleep(0.5)
        puts "It's a draw!"
        play_again?
      end
      switch_player
    end
  end

  # method that outputs the available tic-tac-toe board
  def print_board
    divider = "--+---+---"
    puts "\n#{@board[0]} | #{@board[1]} | #{@board[2]}"
    puts divider
    puts "#{@board[3]} | #{@board[4]} | #{@board[5]}"
    puts divider
    puts "#{@board[6]} | #{@board[7]} | #{@board[8]}\n\n"
    puts "*****************************************************************************"
  end

  # method that makes a position entered by an user not avaiable to enter again
  def update_avaivalbe_positions(pos)
    @available_positions.delete(pos)
  end

  # method that checks whether a player has one the round
  def winner?(player)
    WIN_COMBINATIONS.any? do |combination|
      combination.all? { |pos| @board[pos - 1] == player.marker }
    end
  end

  # method that checks whether the game is a draw, by seeing whether there are any
  #   available positions left
  def draw?
    @available_positions.empty?
  end

  # method that changes from player to another, because its a two player game.
  def switch_player
    @current_player = @current_player == @players[0] ? @players[1] : @players[0]
  end

  # method that asks if the player wants to play again
  def play_again?
    loop do
      print "\nPlay again? y/n:"
      answer = gets.chomp.downcase
      if answer == 'n'
        exit
      elsif answer == 'y'
        initialize
        play
      end
    end
  end
end

new_game = TicTacToe.new
new_game.play
