require 'logger'
require_relative 'moves/b_move'
require_relative 'moves/d_move'
require_relative 'moves/f_move'
require_relative 'moves/l_move'
require_relative 'moves/r_move'
require_relative 'moves/u_move'
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
    add_move('U', -> { UMove.new(@cube, @logger).move })
    add_move('D', -> { DMove.new(@cube, @logger).move })
    add_mid_moves
  end

  def add_multi_move(move, count)
    -> { Array.new(count).each { move[] } }
  end

  def add_move(code, function)
    [code.upcase, code.downcase].each do |coded|
      @moves[coded] = function
      @moves["#{coded}2"] = add_multi_move(@moves[coded], 2)
      @moves["#{coded}'"] = add_multi_move(@moves[coded], 3)
    end
  end

  def add_composite_move(move_id, move_list)
  end

  def add_mid_moves
    if @cube.dimension.odd?
# M3L, S3D
      add_move('M', -> { make_move("R L' x'") })
      add_move('S', -> { make_move("F B' z'") })
      add_move('E', -> { make_move("U D' y'") })
    end
  end

  def add_slice_moves
  end

  def add_bigcube_moves
# T2R, T2L, etc - tier twist, outer layer in (T - T6 on 7x7x7)
# V2R, V2L, etc, verge twist, (all but outer layer, V - V4 on 7x7x7)
# WR  - wide layer (all but outer layers)
# MR - mid layer (M-M4 on 7x7x7)
# N2R, N2L, N2-4L, etc - number layer twist, (N - N3 on 7x7x7)
# S - slice twist - just outer layers (S - S3R on 7x7x7); also slice range S2-3R
# superset ENG
  end
end
