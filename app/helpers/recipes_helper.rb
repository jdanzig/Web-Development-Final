module RecipesHelper

  def edit_recipe_button(recipe)
    link_to edit_recipe_path(recipe) do
      content_tag :i, :class => ['fa','fa-pencil','crud'], :title => 'Edit Recipe' do
      end
    end
  end

  def delete_recipe_button(recipe)
    link_to recipe_path(recipe), :method => :delete, :data => { 'confirm' => "Are you sure you want to delete this recipe?" } do
      content_tag :i, :class => ['fa','fa-trash-o','crud'], :title => 'Delete Recipe' do
      end
    end
  end

end
