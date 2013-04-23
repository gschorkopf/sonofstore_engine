require 'spec_helper'

describe Rating do
  it 'has a valid factory'do
    expect(FactoryGirl.build(:rating)).to be_valid
  end

  it 'is not valid without all attributes' do
    pending
  end
end