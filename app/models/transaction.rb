class Transaction < ApplicationRecord
  DEFAULT_QUANTITY = 5
  validates_presence_of :from, :to, :amount
  after_create :create_block, if: :enough_blocks?

  scope :for_show, ->(quantity = DEFAULT_QUANTITY) { last(DEFAULT_QUANTITY) }

  private

  def enough_blocks?
    Transaction.count >= DEFAULT_QUANTITY
  end

  def create_block
    BlockBuilderService.call.save
  end
end
