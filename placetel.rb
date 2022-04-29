# encoding: utf-8
require "net/http"
require "uri"
require "json"

class Placetel
  attr_accessor :api_key
  API_ENDPOINT = 'https://api.placetel.de/v2'

  def initialize(api_key)
    @api_key = api_key
  end

  def get_numbers
    url = "#{API_ENDPOINT}/numbers"
    page = 1
    allnums = []

    loop do
      page_url = url + "?filter[activated]=true&page=" + page.to_s
      uri = URI.parse(URI.escape(page_url))
      http = Net::HTTP.new(uri.host, uri.port)

      if uri.scheme == 'https'
        http.use_ssl = true
      end

      request = Net::HTTP::Get.new uri.request_uri
      request['Authorization'] = "Bearer #{api_key}"

      req = http.request(request)
      data = JSON.parse(req.body)

      if data.empty?
        break
      end

      allnums += data
      page += 1
    end
    
    allnums
  end

  def initiate_call(from, to)
    json_data = post_request "#{API_ENDPOINT}/calls", { :api_key => @api_key,
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
      request['Authorization'] = "Bearer #{api_key}"
      request.set_form_data post_params

      http.request(request)
    end

end
