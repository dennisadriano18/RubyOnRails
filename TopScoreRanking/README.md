# README
PREREQUISITES
1. Ruby 3.0
2. SQLite3
3. Node.js
4. Yarn
5. Rails 6.0

SETUP INSTRUCTIONS
1. Create a local copy of the git respository [https://github.com/dennisadriano18/RubyOnRails.git]
2. The main branch should have the [TopScoreRanking] project in your local.
3. In the terminal go to the [TopScoreRanking] directory and run the following:
   a.) bundle install. 
   b.) rails generate model player_record name:string score:integer time_entry:datetime
   c.) rails db:migrate
   d.) rails webpacker:install
4. In the [TopScoreRanking] directory, type [rails server]. This should start up the default server 
   
SUPPORTED OPERATIONS - [This API accepts json requests and responds in json format.]
1. ADD PLAYERS
   a.) Your json request needs to have the following fields: ["name", "score", "time"].
   b.) Here's a sample template: [{ "score":(integer score), "name": "(string name)", "time": "(string time - yyyy-mm-dd hh:mm)"}]
   c.) id will automatically be assigned for each player. 
   
2. DELETE PLAYERS
   a.) Your json request needs to have the following fields: ["id"].
   b.) Here's a sample template: [{ "id":(integer id)}]
   
3. READ PLAYERS' RECORDS
   a.) If you will only search for 1 specific player, you will need this field: ["id"]. 
   b.) Here's a sample template: [{ "id":(integer id)}]
   c.) You can also search with multiple parameters such as: start_date, end_date, players' name.
   d.) Here's a sample template: [{"start_date": (string startdate), "end_date": (string enddate), "playerlist": ["(name1)", "(name2)"], "summary": (boolean default false), "current":(integer default 1)}]
   e.) The multiple parameter search supports PAGINATION. 
   f.) Change the [current] value to the next target page. The default item number displayed is 5 per page.
   g.) You can get the Top Score, Lowest Score and Average Score by setting [summary] to true. 
   
NOTE: if you set [summary] to true, pagination will no longer be used and the [current] field is no longer requried. . 

TESTING WITH CLIENT UI
1. Go to [http://localhost:3000/view]. This will display the data in your database table. 
2. Open [http://localhost:3000/clienttest] with another browser.
3. On the left side are textarea's with json values. This will be your template for sending the requests for each operation. 
4. On the right you will see the json response after you click on the button of each operation.
5. Feel free to change the values as per needed. 

TESTING WITH POSTMAN
1. Open postman and create a new request tab. 
2. Change request type to POST. 
3. In the request header, make sure the [Content-Type] is included and is set to [application/json].
4. Add the json input parameters in the request body.    
5. Send the request to any of the 3 URLs below:
   a.) http://localhost:3000/read
   b.) http://localhost:3000/delete
   c.) http://localhost:3000/create
   
TESTING WITH CURL
1. Open terminal.
2. Use any of the sample curl syntax below with a sample json input:
   a.) curl -i -H "Accept: application/json" -H "Content-Type: application/json; charset=utf-8" -X POST -d '{"name": "curl", "score": 10, "time":"2021-05-15 10:50 PM"}'  http://localhost:3000/create
   b.) curl -i -H "Accept: application/json" -H "Content-Type: application/json; charset=utf-8" -X POST -d '{"id":1}'  http://localhost:3000/delete
   c.) curl -i -H "Accept: application/json" -H "Content-Type: application/json; charset=utf-8" -X POST -d '{"start_date": "2021-05-15 22:45:00", "end_date": "2021-05-17 22:45:00", "playerlist": ["javascript2", "me"], "summary": true, "current":2}'  http://localhost:3000/read
   
TESTING WITH RSPEC
1. Open terminal.
2. Go to the [TopScoreRanking] directory
3. type rspec and run. 
4. As per instruction, the summary(top, low, average) for specific players will be checked.
5. Factorybot was used to create dummy information. 


