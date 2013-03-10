# encoding: UTF-8
require "spec_helper"
require "#{File.dirname(__FILE__)}/../phonebook"

describe Phonebook do
  include Rack::Test::Methods

  let(:app) { Phonebook }

  describe "GET /" do
    it "should render successfully" do
      get '/'

      last_response.status.should == 200
    end
  end
end
