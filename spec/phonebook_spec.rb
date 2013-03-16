# encoding: UTF-8
require "spec_helper"
require "#{File.dirname(__FILE__)}/../phonebook"

describe Phonebook do
  include Rack::Test::Methods

  let(:app) { Phonebook }

  describe "GET /" do
    it "should call get_numbers and render successfully" do
      Placetel.any_instance.should_receive(:get_numbers).and_return([])

      get '/'
      last_response.status.should == 200
    end
  end

  describe "GET /initiate_call/:from/:to" do
    it "should call initiate_call and render successfully" do
      Placetel.any_instance.should_receive(:initiate_call).with("a1", "b2")
      get '/initiate_call/a1/b2'

      last_response.status.should == 200
      last_response.body.should == 'done'
    end

    it "should not recognize request if parameters are missing" do
      get '/initiate_call'
      last_response.status.should == 404

      get '/initiate_call/1'
      last_response.status.should == 404

      get '/initiate_call//2'
      last_response.status.should == 404
    end
  end
end
