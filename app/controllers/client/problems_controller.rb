class Client::ProblemsController < ApplicationController
  def index
    response = Unirest.get(
                           "http://localhost:3000/api/problems"
                         
                           )
    @problems = response.body
    render 'index.html.erb'
  end

  def new
    @problem = {}
    render 'new.html.erb'
  end

  def create
    @problem = {
                'prompt' => params[:prompt],
                'solution_tests' => params[:solution_tests]
               }
    response =Unirest.post(
                            "http://localhost:3000/api/problems",
                            parameters: @problem
                            )

    if response.code == 200
      flash[:success] = "Successfully created problem"
      redirect_to "/client/problems/"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to make a problem"
      redirect_to "/"
      
    else
      @errors = response.body["errors"]
      render 'new.html.erb'
    end
  end

  def show
    problem_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/problems/#{problem_id}")
    @problem = response.body
    render 'show.html.erb'
  end

  def edit
    response = Unirest.get("http://localhost:3000/api/problems/#{params[:id]}")
    @problem = response.body
    render 'edit.html.erb'
  end


  def update
    @problem = {
                'prompt' => params[:prompt],
                'solution_tests' => params[:solution_tests]
               }
    response = Unirest.patch(
                            "http://localhost:3000/api/problems/#{params[:id]}",
                            parameters: @problem
                            )

    if response.code == 200
      flash[:success] = "Successfully updated problem"
      redirect_to "/client/problems/#{params[:id]}"
    elsif response.code == 401
      flash[:warning] = "You are not authorized to update a problem"
      redirect_to "/"
      
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end
  end

  def destroy
    response = Unirest.delete("http://localhost:3000/api/problems/#{params['id']}")
    flash[:success] = "Successfully destroyed problem"
    redirect_to "/client/problems"
    else
    flash[:warning] = "You are not authorized to delete a problem"
    redirect_to "/"
  end
end

