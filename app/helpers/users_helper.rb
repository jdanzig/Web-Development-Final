module UsersHelper

  def edit_user_button
    link_to edit_user_path do
      content_tag :i, :class => ['fa','fa-pencil','crud'], :title => 'Update User Info' do
      end
    end
  end

end
