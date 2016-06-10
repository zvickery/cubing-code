require 'logger'

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

    # TODO: validate move string

    moves.each do |move|
      @moves[move].call
    end
  end

  def add_moves
    @moves['X'] = -> { move_x }
    @moves["X'"] = add_3x_move(@moves['X'])
    @moves['Y'] = -> { move_y }
    @moves["Y'"] = add_3x_move(@moves['Y'])
    @moves['Z'] = -> { move_z }
    @moves["Z'"] = add_3x_move(@moves['Z'])
    @moves['F'] = -> { move_f }
    @moves["F'"] = add_3x_move(@moves['F'])
  end

  def add_3x_move(move)
    -> { Array.new(3).each { move[] } }
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
    @logger.info('making a F move')
    tmp = []
    dim = @cube.dimension - 1
    dim.downto(0).each do |i|
      tmp.push(@cube.left.pieces[i][dim])
    end

    # Build new left face
    (0..dim).each do |i|
      @cube.left.pieces[i][dim] = @cube.down.pieces[0][i]
    end

    # Build new down face
    (0..dim).each do |i|
      rev = (i + dim + (dim - 1) * i) % dim + 1
      @cube.down.pieces[0][i] = @cube.right.pieces[rev][0]
    end

    # Build new right face
    (0..dim).each do |i|
      @cube.right.pieces[i][0] = @cube.up.pieces[dim][i]
    end

    # Build new up face
    (0..dim).each do |i|
      @cube.up.pieces[dim][i] = tmp[i]
    end
  end
end
