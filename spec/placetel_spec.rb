require "spec_helper"

describe Placetel do
  let(:subject){ Placetel.new("abc123") }

  context "#initialize" do
    it "should set the correct api_key" do
      subject.instance_variable_get(:"@api_key").should == 'abc123'
    end
  end

  context "#getNumbers" do
    it "should call the correct url and return an array" do
      req = double
      req.stub(:set_form_data)
      Net::HTTP::Post.should_receive(:new).with('/api/getNumbers.json').and_return(req)

      http_response = double
      http_response.stub(:body).and_return([{ :pstn_number => '1' }].to_json)
      Net::HTTP.any_instance.should_receive(:request).with(req).and_return(http_response)

      subject.get_numbers.should == [{ 'pstn_number' => '1' }]
    end

    it "should raise an exception with the wrong API key" do
      expect{ subject.get_numbers }.to raise_error 'Authentication failed. Invalid api key'
    end
  end
end
