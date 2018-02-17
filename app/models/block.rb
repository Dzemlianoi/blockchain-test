class Block < ApplicationRecord
  SHAREABLE_BLOCK_COUNT = 10
  validates_presence_of :hash_data, :prev_hash_data, :tx

  after_create :share_block

  scope :shareable, ->(num_blocks = nil) { last(num_blocks || SHAREABLE_BLOCK_COUNT) }

  private

  def share_block
    SharableService.call(self)
  end
end
