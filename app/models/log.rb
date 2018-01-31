class Log < ActiveRecord::Base
    def self.load_logs(log_file,delete_logs)
	    puts "***** Started Log.load_logs *************"

		guid = nil
		last_guid = nil
		last_text = nil
		details = nil
		text = nil
		sequence = 0

		if delete_logs
			puts"  deleting TempLog"		
			TempLog.delete_all
		end

		File.foreach(log_file){
			|log|
			
			# look for "[guid] text"
			m = /\[(\S*)\]\s(.*)/
			mData = m.match log
			if mData
				guid=mData[1]
				text=mData[2]
			else
				guid = last_guid
				text = log
			end
			
			# Write to Temp_Logs
			@tl = TempLog.new
			@tl.guid = guid
			@tl.sequence = sequence
			@tl.text = text
			@tl.save		

			sequence = sequence + 1
			last_guid = guid
		}
		puts ("loaded " + sequence.to_s + " log entries")
		
		if delete_logs
			puts"  deleting Log"		
			Log.delete_all
		end
			
		last_guid=nil
		TempLog.order(:guid,:sequence).each do |tempLog|
			guid = tempLog.guid
			if guid == last_guid
				if !details
					details = tempLog.text
				else
					details = details + "\n" + tempLog.text
				end
			else
				if last_guid != nil
			   		textArray = text.split(" ")
					#Saving Log Entry
					@l = Log.new
					@l.guid = last_guid
					@l.string_started = textArray[0]
					@l.keyword = textArray[1]
					@l.url = textArray[2]
					@l.string_for = textArray[3]
					@l.ip = textArray[4]
					@l.string_at = textArray[5]
					@l.date = textArray[6]
					@l.time = textArray[7]
					@l.zone = textArray[8]
					@l.details = details
					@l.save		
				end
			text = tempLog.text
			details = nil
			end
		
			last_guid = guid
		end
	end
end
