require 'spec_helper'

describe Tug::Hockeyapp do

  before(:each) do
    @options = {
      :api_token => "api_token",
      :file => "test.ipa",
      :release_notes => "Notes",
      :notify => 1
    }

    @deployer = Tug::Hockeyapp.new(@options)
  end

  describe "when deploying" do

    
  end
end