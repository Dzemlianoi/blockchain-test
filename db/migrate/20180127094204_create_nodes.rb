class CreateNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :nodes, id: false do |t|
      t.integer :id
      t.string :url
      t.timestamps
    end
  end
end
