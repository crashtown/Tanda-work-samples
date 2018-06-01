class CreateEpoches < ActiveRecord::Migration[5.1]
  def change
    create_table :epoches do |t|
      t.integer :date
      t.references :device, foreign_key: true
      t.timestamps
    end
  end
end
