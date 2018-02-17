class BlockSerializer < ActiveModel::Serializer
  attributes :tx, :hash, :prev_hash, :ts

  def hash
    object.hash_data
  end

  def prev_hash
    object.prev_hash_data
  end

  def ts
    object.created_at
  end
end
