# Authors: Jordan Greenbaum, Jacob Krawitz
# Date: 03 December 2021
# Description: A single instance of a tic-tac-toe board.

class Board
    # make instance variable @board publicly readable
    attr_reader :board

    def initialize(array = nil)
        @board = array.nil? ? [" ", " ", " ", " ", " ", " ", " ", " ", " "] : array.clone
    end

    # convert this object to a string
    def to_s
        "  1 2 3\nA " << @board[0] << "|" << @board[1] << "|" << @board[2] << "\n  -•-•-\nB " << @board[3] << "|" << @board[4] << "|" << @board[5] << "\n  -•-•-\nC " << @board[6] << "|" << @board[7] << "|" << @board[8]
    end

    # get slot based on specified row and column
    def get_slot(row, column)
        @board[row * 3 + column]
    end
end