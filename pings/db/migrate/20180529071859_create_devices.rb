class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices do |t|
      t.string :device_id, index: { unique: true}
      t.timestamps
    end
  end
end
