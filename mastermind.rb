class Mastermind

  attr_accessor :code_size, :sercet_code

  def initialize
    @code_size = 4
    @sercet_code = Array.new(@code_size) { rand(1..8)}
    @guess_code = 0
    @tries_limit = 12
  end

  def instructions
    puts "Welcome to the Mastermind!"
    puts "The computer has choosen #{@code_size} numbers between 1 to 8"
    puts "Or if you type y choose a #{@code_size} size sercet code"
    puts "You have 12 tries to guess the serect code"
    puts "Numbers can be use multiple times"
    puts "The computer will give you feedback for each guess"
    puts "Correct number and position will be highlighted"
  end

  def input
    @input = gets.chomp.split("").map(&:to_i)
    if @input.size != 4
      puts "The entry must have a length of 4"
      input
    end
    @input
  end

  def guess_code
    @guess_code += 1
    puts "Guess #{@guess_code}"
    input
  end

  def correct_position
    @correct_position = 0
    @guess = @input.map { |n| n}
    @guess.each_with_index { |num, index| @correct_position += 1 if @sercet_code[index] == num}
    puts "Correct position: #{@correct_position}"
  end

  def correct_guesses
    copy_serect = @sercet_code.map { |n| n}
    index = 0
    @guess.each do |num|
      index = copy_serect.find_index(num)
      copy_serect.delete_at(index) if index
    end
    @correct_guesses = @code_size - copy_serect.size
    puts "Correct guesses: #{@correct_guesses}"
  end

  def won?
    if @correct_position == @code_size
      puts "You win!"
      puts "Serect code: #{sercet_code}"
      exit
    elsif @guess.count == @tries_limit
      puts "You lose!"
      puts "Serect code: #{sercet_code}"
      exit
    end
    play
  end

  def play
    guess_code
    correct_position
    correct_guesses
    won?
  end
end

class Player
  def initialize
    @game = Mastermind.new
    @game.instructions
    create_code
    @game.play
  end

  def create_code
    puts "Do you want to set a serect code [y/n]"
    if gets.chomp.downcase == "y"
      puts "Type a #{@game.code_size} size serect code"
      puts "Only numbers betwwen 1 - 8 please"
      @game.sercet_code = @game.input
      system("clear")
      @game.instructions
    else
      puts "Crack the code!!"
    end
  end
end

Player.new
