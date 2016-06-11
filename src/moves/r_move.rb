# Define a R move
class RMove
  def initialize(cube, logger)
    @cube = cube
    @logger = logger
  end

  def move
    @logger.info('making a R move')
    tmp = []
    dim = @cube.dimension - 1
    dim.downto(0).each do |i|
      tmp.push(@cube.up.pieces[i][dim])
    end

    # Build new up face
    (0..dim).each do |i|
      @cube.up.pieces[i][dim] = @cube.front.pieces[i][dim]
    end

    # Build new front face
    (0..dim).each do |i|
      @cube.front.pieces[i][dim] = @cube.down.pieces[i][dim]
    end

    # Build new down face
    (0..dim).each do |i|
      rev = (i + dim + (dim - 1) * i) % dim + 1
      @cube.down.pieces[i][dim] = @cube.back.pieces[rev][0]
    end

    # Build new back face
    (0..dim).each do |i|
      @cube.back.pieces[i][0] = tmp[i]
    end
  end
end
