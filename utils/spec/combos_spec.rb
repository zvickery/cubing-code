#!/usr/bin/env ruby

require_relative '../combos'

describe CubeCombinations do
  before :each do
    @cube = CubeCombinations.new(7)
  end

  describe '#new' do
    it 'takes one parameters and returns a CubeCombinations object' do
      expect(@cube).to be_an_instance_of CubeCombinations
    end
  end

  describe '#combos' do
    it 'returns the correct cube result' do
      expect(@cube.combos).to eq '1.95E160'
    end
  end

  describe '#supercube_combos' do
    it 'returns the correct supercube result' do
      expect(@cube.supercube_combos).to eq '3.03E211'
    end
  end
end
