# Define a Y move
class YMove
  def initialize(cube, logger)
    @cube = cube
    @logger = logger
  end

  def move
    @logger.info('making a Y move')
    tmp = @cube.front
    @cube.front = @cube.right
    @cube.right = @cube.back
    @cube.back = @cube.left
    @cube.left = tmp
  end
end
