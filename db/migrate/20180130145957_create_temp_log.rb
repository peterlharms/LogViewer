class CreateTempLog < ActiveRecord::Migration
  def change
    create_table :temp_logs do |t|
      t.string :guid
      t.integer :sequence
      t.string :text
    end
  end
end
