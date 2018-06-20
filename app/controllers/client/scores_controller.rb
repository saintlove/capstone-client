class Client::ScoresController < ApplicationController

  def index
    response = Unirest.get(
                           "http://localhost:3000/api/scores"
                         
                           )
    @scores = response.body
    render 'index.html.erb'
  end

  def new
    @score = {}
    render 'new.html.erb'
  end

  def create
    @score = {
                'user_id' => params[:user_id],
                'problem_id' => params[:problem_id],
                'progress' => params[:progress],
                'previous_solution' => params[:previous_solution]
               }
    response =Unirest.post(
                            "http://localhost:3000/api/scores",
                            parameters: @score
                            )

    if response.code == 200
      flash[:success] = "Successfully created score"
      redirect_to "/client/scores/"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to make a score"
      redirect_to "/"
      
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    score_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/scores/#{score_id}")
    @score = response.body
    render 'show.html.erb'
  end

  def edit
    response = Unirest.get("http://localhost:3000/api/scores/#{params[:id]}")
    @score = response.body
    render 'edit.html.erb'
  end


  def update
    @score = {
                'user_id' => params[:user_id],
                'problem_id' => params[:problem_id],
                'progress' => params[:progress],
                'previous_solution' => params[:previous_solution]
               }
    response = Unirest.patch(
                            "http://localhost:3000/api/scores/#{params[:id]}",
                            parameters: @score
                            )

    if response.code == 200
      flash[:success] = "Successfully updated score"
      redirect_to "/client/scores/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update a score"
      redirect_to "/"
      
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end
  end

  def destroy
    response = Unirest.delete("http://localhost:3000/api/scores/#{params['id']}")
    flash[:success] = "Successfully destroyed score"
    redirect_to "/client/scores"
    else
    flash[:warning] = "You are not authorized to delete a score"
    redirect_to "/"
  end
end

