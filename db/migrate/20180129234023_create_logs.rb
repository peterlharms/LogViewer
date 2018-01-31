class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :string_started
      t.string :keyword
      t.string :url
      t.string :string_for
      t.string :ip
      t.string :string_at
      t.string :date
      t.string :time
      t.string :zone

      t.timestamps
    end
  end
end
