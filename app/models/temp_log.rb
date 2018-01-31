class TempLog < ActiveRecord::Base
	def TempLog.dosomething
			puts "in do something"
		TempLog.find_each  do |tempLog|
			puts "tempLog = "
			puts tempLog.id
			puts "tempLog.guid = "
			puts tempLog.guid
			puts "tempLog.text = "
			puts tempLog.text
		end
	end
end
