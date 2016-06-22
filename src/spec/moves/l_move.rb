# Validate the L move
shared_context 'LMoveTest' do
  def validate_l_move(invert = false, double = false)
    @moves.make_move(invert ? %w(L') : %w(L))
    output = @cube.dump_cube
    expect(output).to be_an_instance_of Array

    (0..@dimension - 1).each do |index|
      expect(output[index]).to eq(l_rotation_pattern_one(true, invert, double))
    end

    r = @dimension
    (0..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(l_rotation_pattern_four(invert, double))
    end

    r = @dimension * 2
    (0..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(l_rotation_pattern_one(false, invert, double))
    end
  end

  def l_rotation_pattern_one(top = true, invert = false, double = false)
    pieces = []

    (0..@dimension - 1).each { |_| pieces.push(' ') }

    pieces.push(get_variant_color_one(top, invert, double))

    color = top ? 'R' : 'O'
    (0..@dimension - 2).each { |_| pieces.push(color) }

    pieces.join(' ')
  end

  def get_variant_color_one(top, invert, double)
    if double
      if top
        'O'
      else
        'R'
      end
    elsif invert
      top ? 'W' : 'Y'
    else
      top ? 'Y' : 'W'
    end
  end

  def l_rotation_pattern_four(invert = false, double = false)
    pieces = []
    (0..@dimension - 1).each { |_| pieces.push('B') }
    pieces.push(get_variant_color_four(invert, double, true))
    (1..@dimension - 1).each { |_| pieces.push('W') }
    (0..@dimension - 1).each { |_| pieces.push('G') }
    (0..@dimension - 2).each { |_| pieces.push('Y') }
    pieces.push(get_variant_color_four(invert, double, false))
    pieces.join(' ')
  end

  def get_variant_color_four(invert, double, front)
    if double
      front ? 'Y' : 'W'
    elsif invert
      front ? 'O' : 'R'
    else
      front ? 'R' : 'O'
    end
  end
end
