# Validate the F move
shared_context 'FMoveTest' do
  def validate_f_move(invert = false, double = false)
    @moves.make_move(invert ? %w(F') : %w(F))
    output = @cube.dump_cube
    expect(output).to be_an_instance_of Array
    first_color = if double
                    %w(\  O)
                  else
                    invert ? %w(\  G) : %w(\  B)
                  end
    validate_f_pattern(output, first_color, invert, double)
  end

  def validate_f_pattern(output, first_color, invert, double)
    (0..@dimension - 2).each do |index|
      expect(output[index]).to eq(single_color_per_face(%w(\  R)))
    end
    expect(output[@dimension - 1]).to eq(single_color_per_face(first_color))

    r = @dimension
    (0..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(f_rotation_pattern(invert, double))
    end

    r = @dimension * 2
    expect(output[r]).to eq(single_color_per_face(opposite(first_color)))
    (1..@dimension - 2).each do |index|
      expect(output[r + index]).to eq(single_color_per_face(%w(\  O)))
    end
  end

  def f_rotation_pattern(invert = false, double = false)
    pieces = []
    first_color = if double
                    'G'
                  else
                    invert ? 'R' : 'O'
                  end
    (0..@dimension - 2).each { |_| pieces.push('B') }
    pieces.push(first_color)
    (0..@dimension - 1).each { |_| pieces.push('W') }
    pieces.push(opposite(first_color))
    (0..@dimension - 2).each { |_| pieces.push('G') }
    (0..@dimension - 1).each { |_| pieces.push('Y') }
    pieces.join(' ')
  end
end
