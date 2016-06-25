# Common code for all cube moves
module MoveCommon
  def face_rotation(face, dimension)
    rotate_corners(face, dimension)
    rotate_edges(face, dimension)
  end

  def rotate_corners(face, dimension)
    temp = face.pieces[0][0]
    dim = dimension - 1
    face.pieces[0][0] = face.pieces[dim][0]
    face.pieces[dim][0] = face.pieces[dim][dim]
    face.pieces[dim][dim] = face.pieces[0][dim]
    face.pieces[0][dim] = temp
  end

  def rotate_edges(face, dimension)
    return unless dimension > 2
    dim = dimension - 1

    temp = []
    (1..dim - 1).each { |i| temp.push(face.pieces[0][i]) }
    (1..dim - 1).each do |i|
      rev = (i + dim + (dim - 1) * i) % dim + 1
      face.pieces[0][i] = face.pieces[rev][0]
    end
    (1..dim - 1).each { |i| face.pieces[i][0] = face.pieces[dim][i] }
    (1..dim - 1).each { |i| face.pieces[dim][i] = face.pieces[i][dim] }
    (1..dim - 1).each { |i| face.pieces[i][dim] = temp.shift }
  end
end
