module BlogsHelper
  def choose_path_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_blogs_path
    elsif action_name == 'edit'
      blog_path(@blog[:id])
    end
  end
end
