class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  post '/landmarks/new' do
    @landmark = Landmark.create(params[:landmark])
    erb :'landmarks/index'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/edit'
  end

  post '/landmarks/:id' do 
    @landmark = Landmark.find(params[:id])
    @landmark.name = params[:name]
    @landmark.year_completed = params[:year_completed]
    @landmark.save
    redirect to "/landmarks/#{@landmark.id}"
  end

end
