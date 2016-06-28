# Validate the B move
shared_context 'BMoveTest' do
  def validate_b_move(invert = false, double = false)
    @moves.make_move(invert ? %w(B') : %w(B))
    output = @cube.dump_cube
    expect(output).to be_an_instance_of Array
    first_color = if double
                    %w(\  O)
                  else
                    invert ? %w(\  B) : %w(\  G)
                  end
    validate_b_pattern(output, first_color, invert)
  end

  def validate_b_pattern(output, first_color, invert)
    expect(output[0]).to eq(single_color_per_face(first_color))
    (1..@dimension - 2).each do |index|
      expect(output[index]).to eq(single_color_per_face(%w(\  R)))
    end

    r = @dimension
    (0..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(b_rotation_pattern(invert))
    end

    r = @dimension * 2
    (0..@dimension - 2).each do |index|
      expect(output[r + index]).to eq(single_color_per_face(%w(\  O)))
    end
    color = opposite(first_color)
    expect(output[r + @dimension - 1]).to eq(single_color_per_face(color))
  end

  def b_rotation_pattern(invert = false, double = false)
    pieces = []
    first_color = if double
                    'G'
                  else
                    invert ? 'O' : 'R'
                  end
    pieces.push(first_color)
    (0..@dimension - 2).each { |_| pieces.push('B') }
    (0..@dimension - 1).each { |_| pieces.push('W') }
    (0..@dimension - 2).each { |_| pieces.push('G') }
    pieces.push(opposite(first_color))
    (0..@dimension - 1).each { |_| pieces.push('Y') }
    pieces.join(' ')
  end
end
