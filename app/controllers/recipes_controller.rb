class RecipesController < ApplicationController
  before_action :set_recipe, :only => [:show, :edit, :update, :destroy]

  def index
    @recipes = Recipe.page params[:page]
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = "Recipe Created Successfully"
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:notice] = "Recipe Updated Successfully"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy!
    flash[:notice] = "Recipe Deleted Successfully"
  end

private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

end
