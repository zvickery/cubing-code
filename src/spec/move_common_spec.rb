require 'spec_helper'

describe MoveCommon do
  include MoveCommon

  def validate_reverse(dimension)
    (0..dimension - 1).each do |i|
      expect(reverse(dimension, i)).to eq(dimension - 1 - i)
    end
  end

  describe '#reverse' do
    it 'validates reverse odd' do
      validate_reverse(5)
    end

    it 'validates reverse even' do
      validate_reverse(6)
    end
  end
end
