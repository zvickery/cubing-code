require 'logger'
require_relative 'moves/b_move.rb'
require_relative 'moves/f_move.rb'
require_relative 'moves/r_move.rb'

# Defines moves for arbitrary dimensioned cubes.
class CubeMoves
  def initialize(cube, level = Logger::INFO)
    @logger = Logger.new(STDOUT)
    @logger.level = level
    @cube = cube
    @moves = {}
    add_moves
  end

  def make_move(moves)
    @logger.info("received moves: #{moves}")

    return unless moves

    moves.each do |move|
      raise ArgumentError, "Move #{move} unrecognized" unless @moves.key?(move)
    end

    moves.each do |move|
      @moves[move].call
    end
  end

  def add_moves
    add_move('X', -> { move_x })
    add_move('Y', -> { move_y })
    add_move('Z', -> { move_z })
    add_move('F', -> { move_f })
    add_move('B', -> { move_b })
    add_move('R', -> { move_r })
    add_move('L', -> { move_l })
  end

  def add_3x_move(move)
    -> { Array.new(3).each { move[] } }
  end

  def add_move(code, function)
    @moves[code] = function
    @moves["#{code}'"] = add_3x_move(@moves[code])
  end

  def move_x
    @logger.info('making a X move')
    tmp = @cube.front
    @cube.front = @cube.down
    @cube.down = @cube.back
    @cube.back = @cube.up
    @cube.up = tmp
  end

  def move_y
    @logger.info('making a Y move')
    tmp = @cube.front
    @cube.front = @cube.right
    @cube.right = @cube.back
    @cube.back = @cube.left
    @cube.left = tmp
  end

  def move_z
    @logger.info('making a Z move')
    tmp = @cube.up
    @cube.up = @cube.left
    @cube.left = @cube.down
    @cube.down = @cube.right
    @cube.right = tmp
  end

  def move_f
    f = FMove.new(@cube, @logger)
    f.move
  end

  def move_b
    b = BMove.new(@cube, @logger)
    b.move
  end

  def move_r
    r = RMove.new(@cube, @logger)
    r.move
  end

  def move_l
    l = LMove.new(@cube, @logger)
    l.move
  end
end
