class BlockchainController < ApplicationController
  def last_blocks
    render json: Hashe.last(params['quantity'].to_i).pluck(:hash_block).map { |hash| JSON[hash] }
  end

  def add_data
    block = Block.new(block_params)
    if block.save
      render json: { status: :ok}
    else
      render json: { status: :unprocessable_entity, errors: block.errors }
    end
  end

  private

  def block_params
    params.permit(:data)
  end
end
