# Validate the L move
class LMoveTest
  def initialize(cube, moves)
    @cube = cube
    @moves = moves
  end

  def validate_l_move(invert = false)
    @moves.make_move(invert ? %w(L') : %w(L))
    output = @cube.dump_cube
    expect(output).to be_an_instance_of Array

    (0..@dimension - 1).each do |index|
      expect(output[index]).to eq(l_rotation_pattern_one(true, invert))
    end

    r = @dimension
    (0..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(l_rotation_pattern_four(invert))
    end

    r = @dimension * 2
    (0..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(l_rotation_pattern_one(false, invert))
    end
  end

  def l_rotation_pattern_one(top = true, invert = false)
    pieces = []

    (0..@dimension - 1).each { |_| pieces.push(' ') }

    color = if invert
              top ? 'W' : 'Y'
            else
              top ? 'Y' : 'W'
            end
    pieces.push(color)

    color = top ? 'R' : 'O'
    (0..@dimension - 2).each { |_| pieces.push(color) }

    pieces.join(' ')
  end

  def l_rotation_pattern_four(invert = false)
    pieces = []
    (0..@dimension - 1).each { |_| pieces.push('B') }
    pieces.push(invert ? 'O' : 'R')
    (1..@dimension - 1).each { |_| pieces.push('W') }
    (0..@dimension - 1).each { |_| pieces.push('G') }
    (0..@dimension - 2).each { |_| pieces.push('Y') }
    pieces.push(invert ? 'R' : 'O')
    pieces.join(' ')
  end
end
