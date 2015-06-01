class RecipeReviewsController < ApplicationController
  before_action :set_recipe

  def create
    @recipe_review = @recipe.reviews.build(recipe_review_params)
    @recipe_review.user = current_user
    @saved = @recipe_review.save
    respond_to(:js)
  end

private
  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def recipe_review_params
    params.require(:recipe_review).permit(:rating, :description)
  end
end