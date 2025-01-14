class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get "/animals" do 
    animals = Animal.all
    animals.to_json(methods: [:age])
  end

  get "/animals/a-z" do
    animals = Animal.alphabetical
    animals.to_json(methods: [:age])
  end

  get "/animals/age" do
    animals = Animal.oldest
    animals.to_json(methods: [:age])
  end

  get "/animals/:id" do 
    animal = Animal.find(params[:id])
    ordered_logs = animal.animal_logs.order(:created_at)
    animal.to_json(includes: :animal_logs)
  end

  post "/animals" do 
    animal = Animal.create(animal_params)
    animal.to_json
  end

  patch "/animals/:id" do
    animal = Animal.find(params[:id])
    animal.update(animal_params)
    animal.to_json
  end 

  delete "/animals/:id" do
    animal = Animal.find(params[:id])
    animal.destroy
  end


  get "/zookeepers" do 
  zookeepers = Zookeeper.all
  zookeepers.to_json
  end

  delete "/zookeepers/:id" do
    zookeeper=Zookeeper.find(params[:id])
    zookeeper.destroy
    zookeeper.to_json()
  end

  patch "/zookeepers/:id" do
    zookeeper = Zookeeper.find(params[:id])
    zookeeper.update(name: params[:name], image: params[:image])
    zookeeper.to_json()
  end

  post "/animal_logs" do 
    animal_log = AnimalLog.create(animal_log_params)
    animal_log.to_json(methods: [:formatted_time])
  end

  patch "/animal_logs/:id" do
    animal_log = AnimalLog.find(params[:id])
    animal_log.update(animal_log_params)
    animal_log.to_json(methods: [:formatted_time])
  end

  delete "/animal_logs/:id" do
    animal_log = AnimalLog.find(params[:id])
    animal_log.destroy
    animal_log.to_json(methods: [:formatted_time])
  end

  # get "/animal_logs/zookeeper/:id" do
  #   keeperLogs = AnimalLog.where(zookeeper_id: params[:id])
  #   keeperLogs.to_json

  # end

  get "/animal_logs/animal/:id" do 
    animalLog = AnimalLog.where(animal_id: params[:id]).order(:created_at)
    animalLog.to_json(methods: [:formatted_time])
  end

  # post "/animal_logs" do

  #   newLog = AnimalLog.create(note: params[:note] , 
  #                    animal_id: params[:animal_id],
  #                    zookeeper_id: params[:zookeeper_id],
  #                    pooped: params[:pooped],
  #                    fed: params[:fed]
  #                   )
  #   newLog.to_json
  # end
  
  get "/" do
    { message: "Home Page" }.to_json
  end

  private 

  def animal_log_params
    allowed_params = %w(animal_id log_time pooped fed updated_at id note)
    params.select {|param,value| allowed_params.include?(param)}
  end

  def animal_params 
    allowed_params =%w(name image birthdate species sex id)
    params.select {|param,value| allowed_params.include?(param)}
  end

end
