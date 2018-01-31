class AddGuidToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :guid, :string
  end
end
