# Define a X move
class XMove
  def initialize(cube, logger)
    @cube = cube
    @logger = logger
  end

  def move
    @logger.info('making a X move')
    tmp = @cube.front
    @cube.front = @cube.down
    @cube.down = @cube.back
    @cube.back = @cube.up
    @cube.up = tmp
  end
end
