class StaticPagesController < ApplicationController
    def root
        if user_signed_in?
            redirect_to profile_path(current_user.id)
        end
    end
end
