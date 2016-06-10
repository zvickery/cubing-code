require 'spec_helper'
require_relative './cube_helpers'

describe Cube do
  include CubeHelpers
  it_behaves_like Cube

  before :each do
    build_cube(4)
  end
end
