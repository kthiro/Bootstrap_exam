class BlogMailer < ApplicationMailer
  
  def blog_mail(blog)
    @blog = blog
    mail to: User.find(@blog[:user_id]).email, subject: "新しいブログが作成されました"
  end
  
end