# Validate the U move
shared_context 'UMoveTest' do
  def validate_u_move(invert = false, double = false)
    @moves.make_move(invert ? %w(U') : %w(U))
    output = @cube.dump_cube
    expect(output).to be_an_instance_of Array

    (0..@dimension - 1).each do |index|
      expect(output[index]).to eq(single_color_per_face(%w(\  R)))
    end

    r = @dimension
    expect(output[r]).to eq(u_rotation_pattern(invert, double))
    (1..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(single_color_per_face(%w(B W G Y)))
    end

    r = @dimension * 2
    (0..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(single_color_per_face(%w(\  O)))
    end
  end

  def u_rotation_pattern(invert = false, double = false)
    pieces = []
    colors = %w(W G Y B)

    # Circular shift once for double, twice for invert
    if double
      colors.push(colors.shift)
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
