class Board
  def initialize(id, rows, cols)
    @id = id
    @cols = cols
    @b = rows.times.map do |y|
      r = []
      cols.times do |x|
        r << [x,y,false]
      end
      r
    end
  end
  
  attr_accessor :id, :b

  def randomize_cells!
    @b.each do |row|
      row.each do |cell|
        cell[2] = rand(100) % 3 == 0
      end
    end
  end

  def row_hints
    @b.map do |row|
      row.select{|c| c[2] }.count
    end
  end

  def col_hints
    @cols.times.map do |x|
      @b.map{|r| r[x][2] }.select{|e| e }.count
    end
  end

  def hints
    {row_hints: row_hints, col_hints: col_hints}
  end

  def storage
    dat = [@b.length, @cols] + @b.map{|r| r.map{|e| e[2] ? 1 : 0 }}.flatten
    dat.join(",")
  end

  def self.from_storage(id, stored)
    rows = stored.shift.to_i
    cols = stored.shift.to_i
    b = Board.new(id, rows, cols)
    b.b = rows.times.map do |y|
      r = []
      cols.times do |x|
        n = stored.shift.to_i
        r << [x, y, n == 1]
      end
      r
    end
    b
  end
end
