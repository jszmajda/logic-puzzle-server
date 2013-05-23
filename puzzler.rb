class Puzzler
  def self.new_puzzle(board_id)
    board = Board.new(board_id, 3,4)
    board.randomize_cells!
    board
  end

  def self.solve_puzzle(board_id, solution, cached)
    sol = Board.from_storage(board_id, solution.split(','))
    cached = Board.from_storage(board_id, cached.split(','))
    sol.row_hints == cached.row_hints &&
      sol.col_hints == cached.col_hints
  end
end
