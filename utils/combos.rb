#!/usr/bin/env ruby

# Add a factorial method for integers
class Integer
  def fact
    (1..self).reduce(:*) || 1
  end
end

# Compute the number of permutations for the given dimension.
# Assumes NxNxN non-supercube.
class CubeCombinations
  def initialize(dimension)
    @dim = dimension
  end

  def combos
    term1 = (24 * 2**10 * 12.fact)**(@dim % 2)
    term2 = 7.fact * 3**6
    term3 = 24.fact**((@dim**2 - 2 * @dim) / 4).floor
    numerator = term1 * term2 * term3
    denominator = 4.fact**(6 * ((@dim - 2)**2 / 4)).floor
    format_big(numerator / denominator)
  end

  def supercube_combos
    term1 = (24 * 2**21 * 12.fact)**(@dim % 2)
    term2 = 7.fact * 3**6
    term3 = 24.fact**((@dim**2 - 2 * @dim) / 4).floor
    numerator = term1 * term2 * term3
    denominator = 2**((@dim - 2)**2 / 4).floor
    format_big(numerator / denominator)
  end

  def format_big(n)
    s = n.to_s
    if s.length > 10
      prefix = s[0, 3].insert(1, '.')
      exp = s.length - 1
      "#{prefix}E#{exp}"
    else
      n
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  2.upto(13) do |dim|
    c = CubeCombinations.new(dim)
    puts "A #{dim} dimension cube has #{c.combos} permutations."
    puts "A #{dim} dimension supercube has #{c.supercube_combos} permutations."
  end
end
