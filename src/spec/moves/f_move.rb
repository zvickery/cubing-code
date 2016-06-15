# Validate the F move
shared_context 'FMoveTest' do
  def validate_f_move(invert = false)
    @moves.make_move(invert ? %w(F') : %w(F))
    output = @cube.dump_cube
    expect(output).to be_an_instance_of Array

    (0..@dimension - 2).each do |index|
      expect(output[index]).to eq(single_color_per_face(%w(\  R)))
    end
    color = invert ? %w(\  G) : %w(\  B)
    expect(output[@dimension - 1]).to eq(single_color_per_face(color))

    r = @dimension
    (0..@dimension - 1).each do |index|
      expect(output[r + index]).to eq(f_rotation_pattern(invert))
    end

    r = @dimension * 2
    color = invert ? %w(\  B) : %w(\  G)
    expect(output[r]).to eq(single_color_per_face(color))
    (1..@dimension - 2).each do |index|
      expect(output[r + index]).to eq(single_color_per_face(%w(\  O)))
    end
  end

  def f_rotation_pattern(invert = false)
    pieces = []
    (0..@dimension - 2).each { |_| pieces.push('B') }
    pieces.push(invert ? 'R' : 'O')
    (0..@dimension - 1).each { |_| pieces.push('W') }
    pieces.push(invert ? 'O' : 'R')
    (0..@dimension - 2).each { |_| pieces.push('G') }
    (0..@dimension - 1).each { |_| pieces.push('Y') }
    pieces.join(' ')
  end
end
