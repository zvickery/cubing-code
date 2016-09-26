require 'spec_helper'

describe 'bad dimension' do
  it 'validates bad dimension' do
    expect { Cube.new(1) }.to raise_error(ArgumentError)
  end
end
