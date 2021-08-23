class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get "/animals" do 
    animals = Animal.all
    animals.to_json

  end

  get "/zookeepers" do 
  zookeepeers = Zookeeper.all
  zookeepers.to_json

  end

  get "/animallogs" do 
  animalLogs = AnimalLogs.all
  animalLogs.to_json
  end

  get "/animallogs/zookeeper/:id" do
    keeperLogs = AnimalLog.where(zookeeper_id: params[:id])
    keeperLogs.to_json

  end

  get "/animallogs/animal/:id" do 
    animalLog = AnimalLog.where(animal_id: params[:id])
    animalLog.to_json
  end

  post "/animallogs" do

    newLog = AnimalLog.create(note: params[:note] , 
                     animal_id: params[:animal_id],
                     date: params[:date],
                     last_fed: params[:last_fed],
                     zookeeper_id: params[:zookeeper_id],
                     last_pooped: params[:last_pooped],
                     pooped: params[:pooped]
                    )
    newLog.to_json
  end
  
  get "/" do
    { message: "Home Page" }.to_json
  end
end
