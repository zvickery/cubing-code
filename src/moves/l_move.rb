require_relative './move_common'

# Define a L move
class LMove
  include MoveCommon
  def initialize(cube, logger)
    @cube = cube
    @logger = logger
  end

  def move
    @logger.info('making a L move')
    tmp = []
    dim = @cube.dimension - 1
    (0..dim).each do |i|
      tmp.push(@cube.up.pieces[i][0])
    end

    # Build new up face
    (0..dim).each do |i|
      @cube.up.pieces[i][0] = @cube.back.pieces[i][dim]
    end

    # Build new back face
    (0..dim).each do |i|
      rev = (i + dim + (dim - 1) * i) % dim + 1
      @cube.back.pieces[i][dim] = @cube.down.pieces[rev][0]
    end

    # Build new down face
    (0..dim).each do |i|
      @cube.down.pieces[i][0] = @cube.front.pieces[i][0]
    end

    # Build new front face
    (0..dim).each do |i|
      @cube.front.pieces[i][0] = tmp[i]
    end

    face_rotation(@cube.left, @cube.dimension)
  end
end
