module PostsHelper
    def protect_edition
        if @post.user_id != current_user.id
            redirect_to profiles_path(current_user.id)
        end
    end

    def protect_destroy
        if current_user.adm == true and @post.user_id == current_user.id
        else
            redirect_to profiles_path(current_user.id)
        end
    end
end