require 'spec_helper'

describe BillingAddressesController do
  before (:each) do
    ApplicationController.stub!(:require_login).and_return(true)
  end

  describe 'GET#edit' do
  end

  describe 'PUT#update' do
  end
end
