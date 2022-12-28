class BlogMailer < ApplicationMailer
    def blog_mail(blog)
        @blog = blog
    
        mail to: @blog.user.email, subject: "お問い合わせの確認メール"
    end
end

#mail to: @blog.email, subject: "お問い合わせの確認メール"
#mail to: @blog.user.email, subject: "お問い合わせの確認メール"