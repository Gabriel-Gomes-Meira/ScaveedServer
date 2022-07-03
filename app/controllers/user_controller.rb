class UserController < ApplicationController

  def index
    render json:User.first, status: :ok
  end

  def create
    user = User.new(params_profile)
    if user.save
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    user = User.find({:_id => params[:id]})
    user.update_attributes(params_profile)
    if user.save
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    User.destroy_all({:_id => params[:id]})
  end

  def params_profile
    params.require(:profile).permit(:telegram => {} )
  end
end
