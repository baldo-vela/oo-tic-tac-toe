#our ever handy debugging gem
require 'pry'

class TicTacToe
    #symbolic variable initizalizations
    attr_accessor :board, :winning_player

    #This array represents all the winning board states by a numeric board position. Such would probably be better as a private object, but this is a simple game.
    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    def initialize
        @board = Array.new(9, " ")
        @winning_player = nil
    end


    def display_board
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(index, token = "X")
        @board [index] = token

    end

    def position_taken?(index)
        if @board[index] != " "
            true
        else
            false
        end
    end

    def valid_move?(index)
        if !position_taken?(index) && (index <= 9)
            return true
        else
            return false
        end
    end

    def turn_count
        count = 0
        @board.each do |value|
            if value != " "
                count += 1
            end
        end
        return count
    end

    def current_player
       if turn_count.odd?
        return "O"
       else
        return "X"
       end
    end

    def turn
        puts "Please enter 1-9:"
        input = gets.chomp
        index = input_to_index(input)
        player = current_player
        if valid_move?(index) == true
           move(index, player)
            display_board
        else
            turn
        end
    end

    def won?
        #loop though the board, build arrays to index token positions
        x_indexes = []
        o_indexes = []
        winner = false
        @board.each_with_index do |value, index|
            if value == "X"
                x_indexes << index
            elsif value == "O"
                o_indexes << index
            end
        end

        WIN_COMBINATIONS.each do |winning_array|
            if (winning_array - x_indexes).empty?
                winner = winning_array
                @winning_player = "X"
            elsif (winning_array - o_indexes).empty?
                winner = winning_array
                @winning_player = "O"
            end
        end

        return winner

    end

    def full?
        # check if the board has an empty space left
        @board.all? do |square|
            square == "X" || square == "O"
        end
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        won?
        return @winning_player
    end

    def play
        #primary runtime method
        turn until over?
            if won?
                puts "Congratulations #{@winning_player}!"
            elsif draw?
                puts "Cat's Game!"
            end
    end
end