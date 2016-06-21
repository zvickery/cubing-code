# Methods to generate cube patterns for testing
module CubePatterns
  def single_color_per_face(expected)
    m = expected.map { |i| [i].repeated_combination(@dimension).to_a }
    m.flatten.join(' ')
  end

  def checkerboard(expected, dimension)
    colors = []
    expected.each do |color|
      colors.push(color)
      (1..dimension - 2).each { |_| colors.push(opposite(color)) }
      colors.push(color)
    end

    colors.join(' ')
  end

  def opposite(color)
    opposites = {
      'B' => 'G',
      'G' => 'B',
      'O' => 'R',
      'R' => 'O',
      'W' => 'Y',
      'Y' => 'W'
    }

    if color.respond_to?('map')
      color.map { |c| opposite(c) }
    else
      opposites.key?(color) ? opposites[color] : color
    end
  end
end
