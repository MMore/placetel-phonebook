require "spec_helper"

describe Placetel do
  let(:api_key){ 'abc123' }
  let(:subject){ Placetel.new(api_key) }

  context "#initialize" do
    it "should set the correct api_key" do
      subject.instance_variable_get(:"@api_key").should == api_key
    end
  end

  context "#get_numbers" do
    it "should call the correct url and return an array" do
      req = double
      req.should_receive(:set_form_data).with({ :api_key => api_key })
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

  context "#initiate_call" do
    before(:each) do
      @req = double
      @req.should_receive(:set_form_data).with({ :api_key => api_key, :sipuid => '123@sip.finotel.com',
                                                :target => '0123456'})
      Net::HTTP::Post.should_receive(:new).with('/api/initiateCall.json').and_return(@req)

      @http_response = double
    end

    it "should call the correct url and return true if success" do
      @http_response.stub(:body).and_return({ :result => '1' }.to_json)
      Net::HTTP.any_instance.should_receive(:request).with(@req).and_return(@http_response)

      subject.initiate_call('123@sip.finotel.com', '0123456').should == true
    end

    it "should raise an exception if error" do
      @http_response.stub(:body).and_return({ :result => '-1', :descr => 'error X' }.to_json)
      Net::HTTP.any_instance.should_receive(:request).with(@req).and_return(@http_response)

      expect{ subject.initiate_call('123@sip.finotel.com', '0123456') }.to raise_error 'error X'
    end
  end
end
