class CreateBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :blocks do |t|
      t.string :hash_data
      t.string :prev_hash_data
      t.jsonb :tx
      t.timestamps
    end
  end
end
