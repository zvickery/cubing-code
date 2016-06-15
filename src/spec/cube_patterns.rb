# Methods to generate cube patterns for testing
module CubePatterns
  def single_color_per_face(expected)
    m = expected.map { |i| [i].repeated_combination(@dimension).to_a }
    m.flatten.join(' ')
  end
end
