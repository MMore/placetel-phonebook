# encoding: utf-8
require "net/http"
require "uri"
require "json"

class Placetel
  attr_accessor :api_key
  API_ENDPOINT = 'https://api.placetel.de/api'

  def initialize(api_key)
    @api_key = api_key
  end

  def get_numbers
    json_data = post_request "#{API_ENDPOINT}/getNumbers.json", { :api_key => @api_key }
    raise "no data received" if json_data.body.nil?

    response = JSON.parse(json_data.body.force_encoding('UTF-8'))

    raise response['descr'] if !response.is_a?(Array) || response.first.nil? || response.first['pstn_number'].nil?
    response
  end

  def initiate_call(from, to)
    json_data = post_request "#{API_ENDPOINT}/initiateCall.json", { :api_key => @api_key,
                                                                    :sipuid => from,
                                                                    :target => to }
    raise "no data received" if json_data.body.nil?

    response = JSON.parse(json_data.body.force_encoding('UTF-8'))

    raise response['descr'] if !response.is_a?(Hash) || response['result'] != '1'
    true
  end

  private

    def post_request(url, post_params = {})
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)

      if uri.scheme == 'https'
        http.use_ssl = true
      end

      request = Net::HTTP::Post.new uri.request_uri
      request.set_form_data post_params

      http.request(request)
    end

end
