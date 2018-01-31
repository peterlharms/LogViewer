class LogsController < ApplicationController
	def index
		delete_logs = true
		load_logs = true
		log_file = "/home/student/LogViewer/sourceData/sample.log"

		if load_logs 
			Log.load_logs(log_file,delete_logs)
		end
	
		# Loading up the logs table into a variable to be used on the view
		@LogsFromDb = Log.all

		@queryLog = Log.new
	end
	
	def search
		@sql = nil
		@show = Array.new
		add_item( 'guid',params[:guid] )
		add_item( 'details',params[:details] )
		add_item( 'keyword',params[:keyword] )
		add_item( 'url',params[:url] )
		add_item( 'ip',params[:ip] )
		add_item( 'date',params[:date] )
		add_item( 'time',params[:time] )
				
		puts "-----------------------------------------------"
		puts "search SQL:"
		puts @sql
		if @sql == nil
			puts "empty search"
			@searchResults = Log.all
			return
		end

		@searchResults = Log.find_by_sql(@sql)
		puts "-----------------------------------------------"
	end

	def add_clause( sub_clause )
		if @sql == nil
			@sql = "select * from logs where " + sub_clause
		else
			@sql = @sql + ' and ' + sub_clause
		end
	end

	def add_item( item_name, item )
		if !item || item.length == 0
			return
		end
		add_clause (item_name + " like '%" + item + "%'")
		@show << (item_name + ": " + item)
	end
end
