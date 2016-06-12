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

  def r_rotation_pattern_one(top = true, invert = false)
    pieces = []
    color = top ? 'R' : 'O'
    (0..@dimension - 1).each { |_| pieces.push(' ') }
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

  def l_rotation_pattern_one(top = true, invert = false)
    pieces = []
    color = top ? 'R' : 'O'
    (0..@dimension - 1).each { |_| pieces.push(' ') }
    (0..@dimension - 2).each { |_| pieces.push(color) }
    color = if invert
              top ? 'W' : 'Y'
            else
              top ? 'Y' : 'W'
            end
    pieces.push(color)
    pieces.join(' ')
  end

  def l_rotation_pattern_four(invert = false)
    pieces = []
    (0..@dimension - 1).each { |_| pieces.push('B') }
    pieces.push(invert ? 'O' : 'R')
    (1..@dimension - 1).each { |_| pieces.push('W') }
    (0..@dimension - 1).each { |_| pieces.push('G') }
    (0..@dimension - 2).each { |_| pieces.push('Y') }
    pieces.push(invert ? 'R' : 'O')
    pieces.join(' ')
  end
end
