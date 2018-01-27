require 'net/http'

class Transaction < ApplicationRecord
  QUANTITY = 5
  validates_presence_of :from, :to, :amount
  after_create :create_block, if: :enough_blocks?

  private

  def enough_blocks?
    Transaction.count > QUANTITY
  end

  def create_block
    block = Block.new(base_params)
    if block.save
      Node.pluck(:url).each do |url|
        uri = URI.parse("http://#{url}/blockchain/receive_update")
        http = Net::HTTP.new(uri.host, uri.port)
        req = Net::HTTP::Post.new(uri.to_s, 'Content-Type' => 'application/json')
        req.body = { sender_id: 78, block: {
            ts: block[:created_at].to_i,
            tx: block[:tx],
            hash: block[:hash_data],
            prev_hash: block[:prev_hash_data]
          }
        }.to_json
        http.request(req)
      end
    end
  end

  def init_params
    @blocks = Transaction.last(QUANTITY).map { |trans| { from: trans[:from], to: trans[:to], amount: trans[:amount] } }
    @last_hash_data = Block.last.present? ? Block.last[:hash_data] : '0'
  end

  def build_hash
    Digest::SHA256.hexdigest "#{@last_hash_data}#{created_at.to_i}"
  end

  def base_params
    init_params
    {
      tx: @blocks,
      prev_hash_data: @last_hash_data,
      hash_data: build_hash
    }
  end
end
