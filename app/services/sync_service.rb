class SyncService
  def self.call
    Block.destroy_all
    uri = URI.parse("http://#{Node.first[:url]}/blockchain/get_blocks/1000")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP.get(uri)
    JSON.parse(req).each { |block| Block.create(block) }
  end
end
