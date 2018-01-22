class CreateHashes < ActiveRecord::Migration[5.0]
  def change
    create_table :hashes do |t|
      t.jsonb :hash_block
      t.timestamps
    end
  end
end
