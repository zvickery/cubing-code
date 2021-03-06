require_relative './move_common'

# Define a F move
class FMove
  include MoveCommon
  def initialize(cube, logger)
    @cube = cube
    @logger = logger
  end

  def move
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
      rev = reverse(@cube.dimension, i)
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

    face_rotation(@cube.front, @cube.dimension)
  end
end
