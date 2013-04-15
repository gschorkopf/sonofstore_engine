require 'spec_helper'

describe "Stores" do
  describe "GET /stores" do
    it "works!" do
      get stores_path
      #should redirect
      response.status.should eq(301)
    end
  end
end
