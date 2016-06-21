#!/usr/bin/env ruby

require_relative '../cube'
require_relative '../cube_moves'
require_relative 'moves/b_move'
require_relative 'moves/d_move'
require_relative 'moves/f_move'
require_relative 'moves/l_move'
require_relative 'moves/r_move'
require_relative 'moves/u_move'
require 'cube_patterns'

# Helper methods for generic dimension cube testing.
module CubeHelpers
  include CubePatterns

  def build_cube(dimension)
    @dimension = dimension
    @cube = Cube.new(@dimension)
    @moves = CubeMoves.new(@cube, Logger::WARN)
  end

  def validate_cube
    expect(@cube).to be_an_instance_of Cube
  end

  def validate_bad_move
    expect { @moves.make_move(['A']) }.to raise_error(ArgumentError)
  end

  def validate_dump
    validate_move(nil, %w(\  R), %w(B W G Y), %w(\  O))
  end

  def validate_x_move
    validate_move(%w(X), %w(\  W), %w(B O G R), %w(\  Y))
  end

  def validate_x_invert_move
    validate_move(%w(X'), %w(\  Y), %w(B R G O), %w(\  W))
  end

  def validate_y_move
    validate_move(%w(Y), %w(\  R), %w(W G Y B), %w(\  O))
  end

  def validate_y_invert_move
    validate_move(%w(Y'), %w(\  R), %w(Y B W G), %w(\  O))
  end

  def validate_z_move
    validate_move(%w(Z), %w(\  B), %w(O W R Y), %w(\  G))
  end

  def validate_z_invert_move
    validate_move(%w(Z'), %w(\  G), %w(R W O Y), %w(\  B))
  end

  def validate_move(move, top, middle, bottom)
    @moves.make_move(move)
    output = @cube.dump_cube
    expect(output).to be_an_instance_of Array
    expect(output[0]).to eq(single_color_per_face(top))
    expect(output[@dimension]).to eq(single_color_per_face(middle))
    expect(output[@dimension * 2]).to eq(single_color_per_face(bottom))
  end

  def validate_checkerboard_move
    @moves.make_move(%w(R2 L2 U2 D2 F2 B2))
    output = @cube.dump_cube
    puts(output)
    expect(output).to be_an_instance_of Array

    if @dimension == 2
      validate_dump
      return
    end

    expect(output[0]).to eq(checkerboard(%w(\  R), @dimension))
    (1..@dimension - 2).each do |i|
      expect(output[i]).to eq(checkerboard(%w(\  O), @dimension))
    end
    expect(output[@dimension - 1]).to eq(checkerboard(%w(\  R), @dimension))

    r = @dimension
    expect(output[r]).to eq(checkerboard(%w(B W G Y), @dimension))
    (r + 1..r * 2 - 2).each do |i|
      expect(output[i]).to eq(checkerboard(%w(G Y B W), @dimension))
    end
    expect(output[r * 2 - 1]).to eq(checkerboard(%w(B W G Y), @dimension))

    r = @dimension * 2
    expect(output[r]).to eq(checkerboard(%w(\  O), @dimension))
    (r + 1..r * 3 - 2).each do |i|
      expect(output[i]).to eq(checkerboard(%w(\  R), @dimension))
    end
    expect(output[r * 3 - 1]).to eq(checkerboard(%w(\  O), @dimension))
  end
end

shared_examples_for Cube do
  describe '#new' do
    it 'validates cube construction' do
      validate_cube
    end
  end

  describe 'bad move' do
    it 'validates bad move' do
      validate_bad_move
    end
  end

  describe 'dump_cube' do
    it 'validates cube dump' do
      validate_dump
    end
  end

  describe 'x_move' do
    it 'validates X move' do
      validate_x_move
    end
  end

  describe 'x_invert_move' do
    it "validates X' move" do
      validate_x_invert_move
    end
  end

  describe 'y_move' do
    it 'validates Y move' do
      validate_y_move
    end
  end

  describe 'y_invert_move' do
    it "validates Y' move" do
      validate_y_invert_move
    end
  end

  describe 'z_move' do
    it 'validates Z move' do
      validate_z_move
    end
  end

  describe 'z_invert_move' do
    it "validates Z' move" do
      validate_z_invert_move
    end
  end

  describe 'f_move' do
    include_context 'FMoveTest'
    it 'validates F move' do
      validate_f_move
    end
  end

  describe 'f_invert_move' do
    include_context 'FMoveTest'
    it "validates F' move" do
      validate_f_move(invert: true)
    end
  end

  describe 'f2_move' do
    include_context 'FMoveTest'
    it 'validates F2 move' do
      validate_f_move(double: true)
    end
  end

  describe 'b_move' do
    include_context 'BMoveTest'
    it 'validates B move' do
      validate_b_move
    end
  end

  describe 'b_invert_move' do
    include_context 'BMoveTest'
    it "validates B' move" do
      validate_b_move(invert: true)
    end
  end

  describe 'b2_move' do
    include_context 'BMoveTest'
    it 'validates B2 move' do
      validate_b_move(double: true)
    end
  end

  describe 'r_move' do
    include_context 'RMoveTest'
    it 'validates R move' do
      validate_r_move
    end
  end

  describe 'r_invert_move' do
    include_context 'RMoveTest'
    it "validates R' move" do
      validate_r_move(invert: true)
    end
  end

  describe 'l_move' do
    include_context 'LMoveTest'
    it 'validates L move' do
      validate_l_move
    end
  end

  describe 'l_invert_move' do
    include_context 'LMoveTest'
    it "validates L' move" do
      validate_l_move(invert: true)
    end
  end

  describe 'u_move' do
    include_context 'UMoveTest'
    it 'validates U move' do
      validate_u_move
    end
  end

  describe 'u_invert_move' do
    include_context 'UMoveTest'
    it "validates U' move" do
      validate_u_move(invert: true)
    end
  end

  describe 'u2_move' do
    include_context 'UMoveTest'
    it 'validates U2 move' do
      validate_u_move(double: true)
    end
  end

  describe 'd_move' do
    include_context 'DMoveTest'
    it 'validates D move' do
      validate_d_move
    end
  end

  describe 'd_invert_move' do
    include_context 'DMoveTest'
    it "validates D' move" do
      validate_d_move(invert: true)
    end
  end

  describe 'd2_move' do
    include_context 'DMoveTest'
    it 'validates D2 move' do
      validate_d_move(double: true)
    end
  end

  describe 'checkerboard_move' do
    it 'validates checkerboard move' do
      validate_checkerboard_move
    end
  end
end
