namespace :fetchdata do
  desc "TODO"
  task fetchit: :environment do
	require 'mysql2'
	puts "Enter DB Username for Mysql::"
	user=STDIN.gets.chomp
	puts "Enter DB password::"
	pass=STDIN.gets.chomp
        client=Mysql2::Client.new(:host => 'localhost', :username => user, :password => pass)
	client.query("USE ruby")
	puts "Connected to Database"
	qry1="SELECT * FROM CENSUSDATA WHERE Name=\"for\""
	puts "selecting data through query:: #{qry1} "
	result=client.query(qry1)
	result.each do |row|
		puts row
	end
	 
	qry2="SELECT * FROM CENSUSDATA WHERE Label LIKE \"M%\" AND Concept LIKE \"B%\""
	puts "Selecting data from multiple attributes:: #{qry2}"
	result2=client.query(qry2)
	#puts result2
	result2.each do |x|
		puts x
	end

	client.query("DROP TABLE CENSUSDATA")


  end

end
