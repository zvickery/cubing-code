# Define a Z move
class ZMove
  def initialize(cube, logger)
    @cube = cube
    @logger = logger
  end

  def move
    @logger.info('making a Z move')
    tmp = @cube.up
    @cube.up = @cube.left
    @cube.left = @cube.down
    @cube.down = @cube.right
    @cube.right = tmp
  end
end
