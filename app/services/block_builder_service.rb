class BlockBuilderService
  class << self
    def call
      Block.new(base_params)
    end

    private

    def base_params
      {
        tx: tx,
        prev_hash_data: last_hash_data,
        hash_data: build_hash
      }
    end

    def tx
      ActiveModelSerializers::SerializableResource.new(Transaction.for_show)
    end

    def last_hash_data
      @last_hash_data ||= Block.last.present? ? Block.last[:hash_data] : '0'
    end

    def build_hash
      Digest::SHA256.hexdigest "#{last_hash_data}#{DateTime.now.to_s}"
    end
  end
end
