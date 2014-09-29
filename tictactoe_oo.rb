# tictactoe_oo.rb
# This is an objected oriented version of tic_tac_toe

class Player
  attr_accessor :name, :marker, :chosen_square

  def initialize(n, m)
    self.name = n
    self.marker = m
  end  

end

class Person < Player

  def make_choice
    puts "#{self.name}, please choose an available square from 1 to 9." 
    self.chosen_square = gets.chomp.to_i
  end  

end

class Computer < Player

  def make_choice(results)
    a = results.keys.select { |key| results[key] == " "}
    self.chosen_square = a.sample
  end  

end

class GameBoard
  attr_accessor :results

  FILLER_ROW = "     |     |     "
  DIVIDER_ROW = "-----+-----+-----"

  def initialize
    self.results = { 1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " ", 9 => " "}
  end

  def display_board
    system 'clear'
    puts FILLER_ROW
    puts "  #{results[1]}  |  #{results[2]}  |  #{results[3]}  "
    puts FILLER_ROW
    puts DIVIDER_ROW
    puts FILLER_ROW
    puts "  #{results[4]}  |  #{results[5]}  |  #{results[6]}  "
    puts FILLER_ROW
    puts DIVIDER_ROW
    puts FILLER_ROW
    puts "  #{results[7]}  |  #{results[8]}  |  #{results[9]}  "
    puts FILLER_ROW
    puts " "
  end 

  def available_squares
    results.select {|k, v| v == " "}.keys
  end

end  

class TicTacToe
  attr_accessor :board, :person, :computer

  WINNING_SEQUENCES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  def initialize(name)
    self.board = GameBoard.new
    self.person = Person.new(name, "X")
    self.computer = Computer.new("Computer", "O")
  end
  
  def mark_player_square(square, marker, name)
    board.results[square.to_i] = marker
    board.display_board
  end  

  def check_game_over 
    WINNING_SEQUENCES.each do |sequence|
      if board.results[sequence[0]] == "X" && board.results[sequence[1]] == "X" && board.results[sequence[2]] == "X"  
        return person.name
      elsif board.results[sequence[0]] == "O" && board.results[sequence[1]] == "O" && board.results[sequence[2]] == "O"  
        return computer.name  
      end 
    end  
    if board.results.keys.select { |key| board.results[key] == " "} == []
      return "Tie" 
    end
    nil
  end  

  def play_again?
    puts "Play again? (Y or N)" 
    if gets.chomp.downcase == "y"
      name = person.name
      TicTacToe.new(name).run
    end
  end 

  def run
    board.display_board
    begin
      begin
        person.make_choice
      end until board.available_squares.include?(person.chosen_square) 

      mark_player_square(person.chosen_square, person.marker, person.name)
      game_over = check_game_over
      if game_over
        break
      end  
      computer.make_choice(board.results)
      mark_player_square(computer.chosen_square, computer.marker, computer.name)
      game_over = check_game_over
    end until game_over
    
    if game_over == "Tie" 
      puts "The game ended in a tie."
    else
      puts "The game is over. #{game_over} won."  
    end

    play_again?   
  end 
     
end

puts "Welcome to Tic Tac Toe! What is your name?"
name = gets.chomp
TicTacToe.new(name).run

