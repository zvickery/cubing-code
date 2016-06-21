# Validate the D move
shared_context 'DMoveTest' do
  def validate_d_move(invert = false, double = false)
    @moves.make_move(invert ? %w(D') : %w(D))
    output = @cube.dump_cube
    expect(output).to be_an_instance_of Array

    (0..@dimension - 1).each do |index|
      expect(output[index]).to eq(single_color_per_face(%w(\  R)))
    end

    r = @dimension
    (0..@dimension - 2).each do |index|
      expect(output[r + index]).to eq(single_color_per_face(%w(B W G Y)))
    end
    expect(output[r + @dimension - 1]).to eq(d_rotation_pattern(invert))

    r = @dimension * 2
    (0..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(single_color_per_face(%w(\  O)))
    end
  end

  def d_rotation_pattern(invert = false, double = false)
    pieces = []
    colors = %w(Y B W G)

    # Circular shift once for double, twice for invert
    if double
      colors.unshift(colors.pop)
    elsif invert
      (0..1).each do |_|
        colors.push(colors.shift)
      end
    end

    colors.each do |color|
      (0..@dimension - 1).each { |_| pieces.push(color) }
    end

    pieces.join(' ')
  end
end
