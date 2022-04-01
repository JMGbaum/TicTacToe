# Authors: Jordan Greenbaum, Jacob Krawitz
# Date: 03 December 2021
# Description: Runs a game of tic-tac-toe!

require './LinkedList.rb'
require './Board.rb'

class TicTacToe
    def initialize
        # set up history
        @history = LinkedList.new

        # initialize empty board as first move
        @history.add_last Board.new
        @turn = 0

        @finished = false

        # run game
        self.run
    end

    # run the game
    def run
        # display the menu and have the user select an action
        choice = self.menu

        # loop through actions and menu display until the game is finished
        while choice != "3" and not @finished
            # add a character to the board
            if choice == "1"
                self.move
            # display previous turns and allow the user to jump back in time
            else
                self.display_history
            end
            return if self.game_over
            
            #If the turn has gotten to 9 without a win condition being met, end the loop
            if @turn == 9
                puts @history.get_last
                puts "\nIt's a tie!"
                return
            end

            # redisplay the menu and have the user select a new action
            choice = self.menu
        end
    end

    # display the main menu and return an action
    def menu
        # display the board in its current state
        puts @history.get_last

        # display turn information
        puts "Turn: " << @turn.to_s << ", Next: " << (@turn % 2 == 0 ? "X" : "O")

        # display main menu
        puts "\nWhat would you like to do?"
        puts "==========================="
        puts "1. Play"
        puts "2. View turn history"
        puts "3. Quit"
        puts "\nEnter an option: "

        # get action from the user
        choice = gets.chomp

        #verify that the entered choice is valid
        while choice != "1" and choice != "2" and choice != "3"
            puts "Invalid option! Try again: "
            choice = gets.chomp
        end
        return choice
    end

    # add a new character to the board
    def move
        # increase the turn
        @turn += 1

       # display instructions and get the desired space from the user
        puts "It's " << (@turn % 2 == 1 ? "X" : "O") << "'s turn! Where would you like to move? Enter a row and column (e.g. A1): "
        move = gets.chomp

        # make sure the spot is valid
        valid = false
        while not valid
            # make sure the space is on the board
            if move !~ /^[ABC][123]$/
                puts "You entered an invalid spot! Please try again: "
                move = gets.chomp
            # make sure the space is empty
            elsif @history.get_last.get_slot(move[0].ord-"A".ord, move[1].to_i - 1) != " "
                puts "The spot you entered has already been filled! Please try again: "
                move = gets.chomp
            else
                valid = true
            end
        end

        # add the character to the board and add the new board to the turn list
        @history.add_last(Board.new @history.get_last.board)
        @history.get_last.board[(move[0].ord-"A".ord) * 3 + (move[1].to_i - 1)] = (@turn % 2 == 1 ? "X" : "O")
    end

    # display all previous turns and allow the user to jump back in time
    def display_history
        # display each turn
        i = 0
        @history.each { |turn|
            puts "=== Turn " << i.to_s << " ==="
            puts turn
            i += 1
        }

        # display instructions for jumping back in time and get the user's response
        puts "Enter a move to jump back to or press enter to go back to the menu: "
        move = gets.chomp

        # verify the user's response is valid
        while move != "" and !(Range.new(0, @history.size, true) === move.to_i)
            puts "Invalid response! Enter a move to jump back to or press enter to go back to the menu: "
            move = gets.chomp
        end

        # jump back in time by removing the end of the list if the turn was valid
        if move != ""
            @history.sever!(move.to_i)
            @turn = move.to_i
        end

        # add an empty line to console for clean output
        puts
    end

    # handles win conditions. Returns true if the game is over, otherwise returns false
    def game_over
        # display a message if the game is over saying either X or O is the winner
        # update the @finished flag
        # return true if the game is over, otherwise return false


        #horizontal victories
        #checks if the horizontal spots are not empty, and are the same letter
        #then prints out the board and prints appropriate message
        if @history.get_last.board[0] != " " &&  @history.get_last.board[1] != " " && @history.get_last.board[2] != " "     
            if @history.get_last.board[0] == @history.get_last.board[1] && @history.get_last.board[0] == @history.get_last.board[2]           
                #display winning board    
                puts @history.get_last
                puts "Congratulations, " << @history.get_last.board[0] << "'s won!"
                return true
            end
        end
            

        if @history.get_last.board[3] != " " &&  @history.get_last.board[4] != " " && @history.get_last.board[5] != " " 
            if @history.get_last.board[3] == @history.get_last.board[4] && @history.get_last.board[3] == @history.get_last.board[5]
                puts @history.get_last
                puts "Congratulations, " << @history.get_last.board[3] << "'s won!"
                return true
            end
        end

        if @history.get_last.board[6] != " " &&  @history.get_last.board[7] != " " && @history.get_last.board[8] != " " 
            if @history.get_last.board[6] == @history.get_last.board[7] && @history.get_last.board[6] == @history.get_last.board[8]
                puts @history.get_last
                puts "Congratulations, " << @history.get_last.board[6] << "'s won!"
                return true
            end

        end

        #vertical victories
        #checks if the vertical spots are not empty, and are the same letter
        #then prints out the board and prints appropriate message
        if @history.get_last.board[0] != " " &&  @history.get_last.board[3] != " " && @history.get_last.board[6] != " " 
            if @history.get_last.board[0] == @history.get_last.board[3] && @history.get_last.board[0] == @history.get_last.board[6]
                puts @history.get_last
                puts "Congratulations, " << @history.get_last.board[0] << "'s won!"
                return true
            end

        end

        if @history.get_last.board[1] != " " &&  @history.get_last.board[4] != " " && @history.get_last.board[7] != " " 
            if @history.get_last.board[1] == @history.get_last.board[4] && @history.get_last.board[1] == @history.get_last.board[7]
                puts @history.get_last
                puts "Congratulations, " << @history.get_last.board[1] << "'s won!"
                return true
            end

        end

        if @history.get_last.board[2] != " " &&  @history.get_last.board[5] != " " && @history.get_last.board[8] != " " 
            if @history.get_last.board[2] == @history.get_last.board[5] && @history.get_last.board[2] == @history.get_last.board[8]
                puts @history.get_last
                puts "Congratulations, " << @history.get_last.board[2] << "'s won!"
                return true
            end

        end

        #diagonal victories
        #checks if the diagonal spots are not empty, and are the same letter
        #then prints out the board and prints appropriate message
        if @history.get_last.board[0] != " " &&  @history.get_last.board[4] != " " && @history.get_last.board[8] != " " 
            if @history.get_last.board[0] == @history.get_last.board[4] && @history.get_last.board[0] == @history.get_last.board[8]
                puts @history.get_last
                puts "Congratulations, " << @history.get_last.board[0] << "'s won!"
                return true
            end

        end

        if @history.get_last.board[2] != " " &&  @history.get_last.board[4] != " " && @history.get_last.board[6] != " " 
            if @history.get_last.board[2] == @history.get_last.board[4] && @history.get_last.board[2] == @history.get_last.board[6]
                puts @history.get_last
                puts "Congratulations, " << @history.get_last.board[2] << "'s won!"
                return true
            end

        end

    end
end

TicTacToe.new