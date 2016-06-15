# Validate the B move
shared_context 'BMoveTest' do
  def validate_b_move(invert = false)
    @moves.make_move(invert ? %w(B') : %w(B))
    output = @cube.dump_cube
    expect(output).to be_an_instance_of Array

    color = invert ? %w(\  B) : %w(\  G)
    expect(output[0]).to eq(single_color_per_face(color))
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
    color = invert ? %w(\  G) : %w(\  B)
    expect(output[r + @dimension - 1]).to eq(single_color_per_face(color))
  end

  def b_rotation_pattern(invert = false)
    pieces = []
    pieces.push(invert ? 'O' : 'R')
    (0..@dimension - 2).each { |_| pieces.push('B') }
    (0..@dimension - 1).each { |_| pieces.push('W') }
    (0..@dimension - 2).each { |_| pieces.push('G') }
    pieces.push(invert ? 'R' : 'O')
    (0..@dimension - 1).each { |_| pieces.push('Y') }
    pieces.join(' ')
  end
end
