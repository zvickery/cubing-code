# Define a D move
class DMove
  def initialize(cube, logger)
    @cube = cube
    @logger = logger
  end

  def move
    @logger.info('making a D move')
    tmp = []
    dim = @cube.dimension - 1
    (0..dim).each do |i|
      tmp.push(@cube.front.pieces[dim][i])
    end

    # Build new front face
    (0..dim).each do |i|
      @cube.front.pieces[dim][i] = @cube.left.pieces[dim][i]
    end

    # Build new left face
    (0..dim).each do |i|
      @cube.left.pieces[dim][i] = @cube.back.pieces[dim][i]
    end

    # Build new back face
    (0..dim).each do |i|
      @cube.back.pieces[dim][i] = @cube.right.pieces[dim][i]
    end

    # Build new right face
    (0..dim).each do |i|
      @cube.right.pieces[dim][i] = tmp[i]
    end
  end
end
