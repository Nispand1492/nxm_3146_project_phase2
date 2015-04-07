namespace :formysql do
  desc "TODO"
  task configure: :environment do
	require 'httparty'
	require 'json'

	response= HTTParty.get("http://api.census.gov/data/2013/acs5/variables.json")
	fname = "mydata.txt"
	somefile = File.open(fname,'w')
	somefile.write(response.body)
	somefile.close
	puts "File made and data written" 
	json=JSON.parse(response.body)
	begin
		puts "Data Dowloaded SuccessFully"

	rescue
		puts "didnt get data"
	end
  end
end 

