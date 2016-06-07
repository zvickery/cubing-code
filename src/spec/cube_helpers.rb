#!/usr/bin/env ruby

require_relative '../cube'
require_relative '../cube_moves'

# Helper methods for generic dimension cube testing.
module CubeHelpers
  def build_cube(dimension)
    @dimension = dimension
    @cube = Cube.new(@dimension)
    @moves = CubeMoves.new(@cube, Logger::WARN)
  end

  def validate_cube
    expect(@cube).to be_an_instance_of Cube
  end

  def build_test_output(expected)
    expected.map { |i| [i].repeated_combination(@dimension).to_a }.flatten.join(' ')
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
    expect(output[0]).to eq(build_test_output(top))
    expect(output[@dimension]).to eq(build_test_output(middle))
    expect(output[@dimension * 2]).to eq(build_test_output(bottom))
  end
end

shared_examples_for Cube do
  describe '#new' do
    it 'validates cube construction' do
      validate_cube
    end
  end

  describe '#dump_cube' do
    it 'validates cube dump' do
      validate_dump
    end
  end

  describe '#x_move' do
    it 'validates X move' do
      validate_x_move
    end
  end

  describe '#x_invert_move' do
    it "validates X' move" do
      validate_x_invert_move
    end
  end

  describe '#y_move' do
    it 'validates Y move' do
      validate_y_move
    end
  end

  describe '#y_invert_move' do
    it "validates Y' move" do
      validate_y_invert_move
    end
  end

  describe '#z_move' do
    it 'validates Z move' do
      validate_z_move
    end
  end

  describe '#z_invert_move' do
    it "validates Z' move" do
      validate_z_invert_move
    end
  end
end
