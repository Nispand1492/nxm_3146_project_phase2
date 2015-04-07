namespace :toworkwithmysql do
  desc "TODO"
  task configmysql: :environment do
	require 'mysql2'
	puts "Enter DB user"
	user=STDIN.gets.chomp
	puts "Enter DB Password"
	pass=STDIN.gets.chomp
  	client=Mysql2::Client.new(:host => 'localhost', :username => user, :password => pass)
	client.query('CREATE DATABASE IF NOT EXISTS ruby')
	puts "Database Created Successfully"	
	client.query('USE ruby')
	client.query('CREATE TABLE IF NOT EXISTS 
			CENSUSDATA (
					Name VARCHAR(80) PRIMARY KEY,	
					Label VARCHAR(80),
					Concept VARCHAR(80),
					Required VARCHAR(30),
					PredicateType VARCHAR(50)
				   )'
		      )
	puts 'table created'
	myfile="mydata.txt"
	mydata = open(myfile).read
	json=JSON.parse(mydata)
#	puts json
        result = json["variables"]
#	puts result["for"]
	i=1
	result.each do |x|
#		puts x
#		puts x.class
#		puts result[x[0]]['label']
		if result[x[0]]['label'].include?'\' '
		   result[x[0]]['label'].gsub!('\'', ' ')
		end
		puts "inserting data #{i}"
                q = "INSERT INTO CENSUSDATA VALUES (\"#{x[0]}\",\"#{result[x[0]]['label']}\",\"#{result[x[0]]['concept']}\",\"#{result[x[0]]['predicateType']}\",\"#{result[x[0]]['predicateOnly']}\")"
		puts q
		client.query(q)
		i = i+1
		if i==11000
			break;
		end	

	end
	puts "number of records #{i}"
	client.close
  end

end
