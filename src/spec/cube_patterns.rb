# Methods to generate cube patterns for testing
module CubePatterns
  def single_color_per_face(expected)
    m = expected.map { |i| [i].repeated_combination(@dimension).to_a }
    m.flatten.join(' ')
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
