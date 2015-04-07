namespace :mongofetch do
  desc "TODO"
  task fetchmongo: :environment do	
	require 'rubygems'
        require 'mongo'
        conn = Mongo::Client.new(['127.0.0.1:27017'], :database => 'test')
	puts "Gettting Single Data From Primary Key"
	result = conn[:CENSUSDATA].find("label": "Census API FIPS 'for' clause")
	result.each do |data|
		puts data
	end

	result2 = conn[:CENSUSDATA].find({'label':/Male/,'concept':/^B0/})
	puts "Getting Multiple Data Using Multiple Attributes"
	result2.each do |x|
		puts x
	end
	
	
  end

end
