require_relative './move_common'

# Define a B move
class BMove
  include MoveCommon
  def initialize(cube, logger)
    @cube = cube
    @logger = logger
  end

  def move
    @logger.info('making a B move')
    tmp = []
    dim = @cube.dimension - 1
    (0..dim).each do |i|
      tmp.push(@cube.left.pieces[i][0])
    end

    # Build new left face
    (0..dim).each do |i|
      @cube.left.pieces[i][0] = @cube.up.pieces[0][i]
    end

    # Build new up face
    (0..dim).each do |i|
      @cube.up.pieces[0][i] = @cube.right.pieces[i][dim]
    end

    # Build new right face
    (0..dim).each do |i|
      rev = (i + dim + (dim - 1) * i) % dim + 1
      @cube.right.pieces[i][dim] = @cube.down.pieces[dim][rev]
    end

    # Build new down face
    (0..dim).each do |i|
      @cube.down.pieces[dim][i] = tmp[i]
    end

    face_rotation(@cube.back, @cube.dimension)
  end
end
