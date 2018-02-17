class BlockchainController < ApplicationController
  def receive_update
    render json: { status: :unprocessable_entity, errors: 'No valid block' } and return if Node.find_by(id: block_params[:sender_id]).nil?
    save_block and return unless Block.last.present?
    save_block and return if received_params[:prev_hash] == Block.last[:hash_data]
    render json: { status: :unprocessable_entity, errors: 'No valid block' }
  end

  def get_blocks
    blocks = Block.last(params['num_blocks']).map do |block|
      {
        ts: block[:created_at],
        tx: block[:tx],
        hash: block[:hash_data],
        prev_hash: block[:prev_hash_data]
      }
    end
    render json: blocks
  end

  private

  def save_block
    block = Block.new(received_create_params)
    if block.save
      render json: { status: :created }
    else
      render json: { status: :unprocessable_entity, errors: block.errors }
    end
  end

  def received_create_params
    {
      prev_hash_data: block_params[:block][:prev_hash],
      hash_data: block_params[:block][:hash],
      tx: block_params[:block][:tx]
    }
  end

  def block_params
    params.permit(:sender_id, block: [:prev_hash, :hash, tx:[:from, :to, :amount]])
  end

  def received_params
    params.permit(:ts, :prev_hash, :hash, tx:[:from, :to, :amount])
  end
end
