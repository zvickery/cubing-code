require 'logger'
require_relative 'moves/b_move'
require_relative 'moves/f_move'
require_relative 'moves/l_move'
require_relative 'moves/r_move'
require_relative 'moves/x_move'
require_relative 'moves/y_move'
require_relative 'moves/z_move'

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
    add_move('X', -> { XMove.new(@cube, @logger).move })
    add_move('Y', -> { YMove.new(@cube, @logger).move })
    add_move('Z', -> { ZMove.new(@cube, @logger).move })
    add_move('F', -> { FMove.new(@cube, @logger).move })
    add_move('B', -> { BMove.new(@cube, @logger).move })
    add_move('R', -> { RMove.new(@cube, @logger).move })
    add_move('L', -> { LMove.new(@cube, @logger).move })
  end

  def add_3x_move(move)
    -> { Array.new(3).each { move[] } }
  end

  def add_move(code, function)
    @moves[code] = function
    @moves["#{code}'"] = add_3x_move(@moves[code])
  end
end
