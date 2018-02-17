class StatusService
  class << self
    def call
      {
        id: Rails.application.credentials.id.to_s,
        name: Rails.application.credentials.name,
        url: Rails.application.credentials.url,
        last_hash: last_hash,
        neighbours: ActiveModelSerializers::SerializableResource.new(Node.all)
      }
    end

    private

    def last_hash
      Block.last.present? ? Block.last[:hash_data] : '0'
    end
  end
end
