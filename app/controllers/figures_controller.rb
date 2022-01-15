class FiguresController < ApplicationController
  get '/figures' do
    @figures = Figure.all 
    erb :'figures/index'
  end

  get '/figures/new' do 
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end

  get '/figures/:id' do 
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  get '/figures/:id/edit' do 
    @titles = Title.all
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  post '/figures/new' do 
    @figures = Figure.all
    @figure = Figure.create(params[:figure])

    if params[:title][:name] == "" && params[:landmark][:name] != ""
      @figure.landmarks << Landmark.create(params[:landmark])
    elsif params[:title][:name] != "" && params[:landmark][:name] != ""
      @figure.titles << Title.create(params[:title])
    else 
      @figure.landmarks << Landmark.create(params[:landmark])
      @figure.titles << Title.create(params[:title])
    end
    erb :'figures/index'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])
    hash = {:name => params[:title]}
    unless hash[:name].empty?
      @figure.titles << Title.create(hash)
    end
    unless params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
end
