class IngredientsController < ApplicationController
  before_action :set_ingredient, :only => [:show,:edit,:update,:destroy]

  def index
    @ingredients = Ingredient.all
    respond_to(:html)
  end

  def show
    respond_to(:html)
  end

  def new
    @ingredient = Ingredient.new
    respond_to(:html)
  end

  def create
    @ingredient = Ingredient.new ingredient_params
    if @ingredient.save
      flash[:notice] = "Ingredient saved successfully"
      redirect_to @ingredient
    else
      flash[:error] = "Ingredient failed to save"
      respond_to do |format|
        format.html { render :new }
      end
    end
  end

  def edit
    respond_to(:html)
  end

  def update
    if @ingredient.update(ingredient_params)
      flash[:notice] = "Ingredient saved successfully"
      redirect_to @ingredient
    else
      flash[:error] = "Ingredient failed to save"
      respond_to do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    @ingredient.destroy!
    flash[:notice] = "Ingredient destroyed successfully"
    redirect_to ingredients_path
  end

private
  def ingredient_params
    params.require(:ingredient).permit(:name, :description, :picture)
  end

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

end