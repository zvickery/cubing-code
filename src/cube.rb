# A cube face, containing color and adjacency
class Face
  attr_accessor :color, :pieces

  def initialize(dimension, color)
    @dimension = dimension
    @color = color
    @pieces = []
    build_faces
  end

  def build_faces
    1.upto(@dimension) do
      row = []
      1.upto(@dimension) do
        row.push(@color)
      end
      @pieces << row
    end
  end
end

# The cube itself!
class Cube
  attr_accessor :front, :back, :left, :right, :up, :down

  def initialize(dimension)
    @dimension = dimension
    @faces = {}
    build_faces
  end

  def build_faces
    colors = [:white, :yellow, :red, :orange, :blue, :green]
    colors.each do |color|
      @faces[color] = Face.new(@dimension, color)
    end

    @front = @faces[:white]
    @back = @faces[:yellow]
    @left = @faces[:blue]
    @right = @faces[:green]
    @up = @faces[:red]
    @down = @faces[:orange]
  end

  def dump_cube
    rows = build_padded_rows

    dump_face_to_rows(@up, rows[0, @dimension])

    [@left, @front, @right, @back].each do |face|
      dump_face_to_rows(face, rows[@dimension, @dimension])
    end

    dump_face_to_rows(@down, rows[@dimension * 2, @dimension])

    output = []
    rows.each do |row|
      output.push(row.map { |i| i[0].upcase }.join(' '))
    end

    output
  end

  def build_padded_rows
    rows = []

    (0..@dimension**2 - 1).each do |i|
      rows.push([])

      # Now pad the output for U and D facew
      next if i / @dimension == 1

      1.upto(@dimension) do
        rows[i].push(' ')
      end
    end

    rows
  end

  def dump_face_to_rows(face, rows)
    (0..@dimension - 1).each do |i|
      rows[i].push(*face.pieces[i])
    end
  end
end
