class DropLogs < ActiveRecord::Migration
  def up
  	connection.execute 'drop table if exists campaigns'
  end
end
