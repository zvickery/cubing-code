# Validate the R move
shared_context 'RMoveTest' do
  def validate_r_move(invert = false)
    @moves.make_move(invert ? %w(R') : %w(R))
    output = @cube.dump_cube
    expect(output).to be_an_instance_of Array

    (0..@dimension - 1).each do |index|
      expect(output[index]).to eq(r_rotation_pattern_one(true, invert))
    end

    r = @dimension
    (0..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(r_rotation_pattern_four(invert))
    end

    r = @dimension * 2
    (0..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(r_rotation_pattern_one(false, invert))
    end
  end

  def r_rotation_pattern_one(top = true, invert = false)
    pieces = []

    (0..@dimension - 1).each { |_| pieces.push(' ') }

    color = top ? 'R' : 'O'
    (0..@dimension - 2).each { |_| pieces.push(color) }

    color = if invert
              top ? 'Y' : 'W'
            else
              top ? 'W' : 'Y'
            end
    pieces.push(color)

    pieces.join(' ')
  end

  def r_rotation_pattern_four(invert = false)
    pieces = []
    (0..@dimension - 1).each { |_| pieces.push('B') }
    (0..@dimension - 2).each { |_| pieces.push('W') }
    pieces.push(invert ? 'R' : 'O')
    (0..@dimension - 1).each { |_| pieces.push('G') }
    pieces.push(invert ? 'O' : 'R')
    (0..@dimension - 2).each { |_| pieces.push('Y') }
    pieces.join(' ')
  end
end
