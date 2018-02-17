require 'net/http'

class ManagementController < ApplicationController
  ID = 78
  NAME = 'zhira_78'
  URL = '192.168.44.78:3000'

  def sync
    Block.destroy_all
    uri = URI.parse("http://#{Node.first[:url]}/blockchain/get_blocks/1000")
    http = Net::HTTP.new(uri.host, uri.port)
    req = Net::HTTP.get(uri)
    JSON.parse(req).each do |block|
      Block.create({
        prev_hash_data: block[:prev_hash],
        hash_data: block[:hash],
        tx: block[:tx]
      }
    )
    end
  end

  def add_link
    node = Node.new(node_params)
    if node.save
      render json: { status: :ok}
    else
      render json: { status: :unprocessable_entity, errors: node.errors }
    end
  end

  def add_transaction
    transaction = Transaction.new(transaction_params)
    if transaction.save
      render json: { status: :ok }
    else
      render json: { status: :unprocessable_entity, errors: transaction.errors }
    end
  end

  def status
    render json: {
      id: ID,
      name: NAME,
      url: URL,
      last_hash: Block.last.present? ? Block.last[:hash_data] : '0',
      neighbours: Node.pluck(:id)
    }
  end

  private

  def transaction_params
    params.permit(:from, :to, :amount)
  end

  def node_params
    params.permit(:id, :url)
  end
end
