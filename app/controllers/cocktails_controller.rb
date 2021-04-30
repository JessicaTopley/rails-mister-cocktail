class CocktailsController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
     if params[:search].present?
      @cocktails = Cocktail.perform_search(params[:search])
    else
      @cocktails = Cocktail.all
    end
  end 
  
  def index
    @user = current_user
  end

  def new
    @cocktail = Cocktail.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else 
      render :new
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.destroy
    redirect_to cocktails_path
  end

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo, :user_id, :search)
  end
end
