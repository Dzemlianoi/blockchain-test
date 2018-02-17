class BlockchainController < ApplicationController
  def receive_update
    save_block and return if ReceiveUpdateService.new(params.extract(:prev_hash, :id)).can_save?
    render failure_response and return unless
  end

  def get_blocks
    render json: Block.shareable(params[:num_blocks])
  end

  private

  def save_block
    block = Block.new(received_create_params)
    block.save ? success_response({ status: :created }) : failure_response({ entity: block })
  end

  def received_create_params
    block_params.extract(:prev_hash, :hash, :tx)
  end

  def block_params
    params.permit(:sender_id, block: [:prev_hash, :hash, tx:[:from, :to, :amount]])
  end
end
