class FavoritesController < ApplicationController
  before_action :require_login
  def create
    recipe = Recipe.find(params[:recipe_id])
    raise ActiveRecord::RecordNotFound unless recipe
    current_user.favorite_recipes << recipe
    head :ok
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    raise ActiveRecord::RecordNotFound unless recipe
    current_user.favorite_recipes -= [recipe]
    head :ok
  end
end
