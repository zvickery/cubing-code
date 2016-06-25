require_relative './move_common'

# Define a U move
class UMove
  include MoveCommon
  def initialize(cube, logger)
    @cube = cube
    @logger = logger
  end

  def move
    @logger.info('making a U move')
    tmp = []
    dim = @cube.dimension - 1
    (0..dim).each do |i|
      tmp.push(@cube.front.pieces[0][i])
    end

    # Build new front face
    (0..dim).each do |i|
      @cube.front.pieces[0][i] = @cube.right.pieces[0][i]
    end

    # Build new right face
    (0..dim).each do |i|
      @cube.right.pieces[0][i] = @cube.back.pieces[0][i]
    end

    # Build new back face
    (0..dim).each do |i|
      @cube.back.pieces[0][i] = @cube.left.pieces[0][i]
    end

    # Build new left face
    (0..dim).each do |i|
      @cube.left.pieces[0][i] = tmp[i]
    end

    face_rotation(@cube.up, @cube.dimension)
  end
end
