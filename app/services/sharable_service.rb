require 'net/http'

class SharableService
  def self.call(block)
    Node.pluck(:url).each do |url|
      uri = URI.parse("http://#{url}/blockchain/receive_update")
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::Post.new(uri.to_s, 'Content-Type' => 'application/json')
      req.body = { sender_id: 78, block: block }.to_json
      http.request(req)
    end
  end
end
