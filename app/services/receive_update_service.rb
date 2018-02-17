class ReceiveUpdateService
  def can_save?(params)
    in_node_list?(params[:sender_id]) && (block_exists? || equal_hashes?(params[:prev_hash]))
  end

  def block_exists?
    Block.last.present?
  end

  def equal_hashes?(prev_hash)
    prev_hash == Block.last[:hash_data]
  end

  def in_node_list?(sender_id)
    Node.exists?(id: sender_id)
  end
end
