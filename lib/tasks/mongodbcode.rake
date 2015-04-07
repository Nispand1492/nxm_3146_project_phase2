namespace :mongodbcode do
  desc "TODO"
  task cmongodata: :environment do
	require 'rubygems'
	require 'mongo'
	conn = Mongo::Client.new(['127.0.0.1:27017'], :database => 'test')
	myfile="mydata.txt"
	i=1
	mydata=open(myfile).read
	json=JSON.parse(mydata)
#	coll = conn.collection("test Collection")
	result=json["variables"]
	result.each do |data|
	puts "Inserting data #{i}"		
	id = conn['CENSUSDATA'].insert_one(result[data[0]])
	i = i+1
	if i==13000
		break
	end
	end
	puts "Data Inserted Into MongoDb:: #{i}"
  end

end
