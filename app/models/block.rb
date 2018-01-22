class Block < ApplicationRecord
  QUANTITY = 5

  validates :data, presence: true

  after_create :create_hash, if: :enough_blocks?

  private

  def enough_blocks?
    Block.count > QUANTITY
  end

  def create_hash
    init_params
    Hashe.create(hash_block: build_params.to_json)
  end

  def init_params
    @current_timestamp = DateTime.now.to_i
    @blocks = Block.last(QUANTITY).pluck(:data)
    @last_hash = Hashe.last.present? ? JSON(Hashe.last&.hash_block)['block_hash'] : '0'
  end

  def build_params
    sha = Digest::SHA2.new
    sha.update(@last_hash).update(@current_timestamp.to_s).update(@blocks.join)
    base_params.merge(block_hash: sha.hexdigest)
  end

  def base_params
    {
      previous_block_hash: @last_hash,
      rows: @blocks.to_a,
      timestamp: @current_timestamp
    }
  end
end
