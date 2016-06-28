# Validate the R move
shared_context 'RMoveTest' do
  def validate_r_move(invert = false, double = false)
    @moves.make_move(invert ? %w(R') : %w(R))
    output = @cube.dump_cube
    expect(output).to be_an_instance_of Array

    (0..@dimension - 1).each do |index|
      expect(output[index]).to eq(r_rotation_pattern_one(true, invert, double))
    end

    r = @dimension
    (0..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(r_rotation_pattern_four(invert, double))
    end

    r = @dimension * 2
    (0..@dimension - 1).each do |index|
      ri = r + index
      expect(output[ri]).to eq(r_rotation_pattern_one(false, invert, double))
    end
  end

  def r_rotation_pattern_one(top = true, invert = false, double = false)
    pieces = []

    (0..@dimension - 1).each { |_| pieces.push(' ') }

    color = top ? 'R' : 'O'
    (0..@dimension - 2).each { |_| pieces.push(color) }

    pieces.push(get_variant_color_one(top, invert, double))

    pieces.join(' ')
  end

  def get_variant_color_one(top, invert, double)
    if double
      get_variant_color_one_double(top)
    elsif invert
      top ? 'Y' : 'W'
    else
      top ? 'W' : 'Y'
    end
  end

  def get_variant_color_one_double(top)
    top ? 'O' : 'R'
  end

  def r_rotation_pattern_four(invert = false, double = false)
    pieces = []
    (0..@dimension - 1).each { |_| pieces.push('B') }
    (0..@dimension - 2).each { |_| pieces.push('W') }
    pieces.push(get_variant_color_four(invert, double, true))
    (0..@dimension - 1).each { |_| pieces.push('G') }
    pieces.push(get_variant_color_four(invert, double, false))
    (0..@dimension - 2).each { |_| pieces.push('Y') }
    pieces.join(' ')
  end

  def get_variant_color_four(invert, double, front)
    if double
      front ? 'Y' : 'W'
    elsif invert
      front ? 'R' : 'O'
    else
      front ? 'O' : 'R'
    end
  end
end
