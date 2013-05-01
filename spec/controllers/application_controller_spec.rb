require 'spec_helper'

describe ApplicationController do
  describe '#require stocker' do
    it 'determines if a user is allowed to have stocker access' do
      expect(require_stocker).to return_true
    end
  end
end
