class ProfilesController < ApplicationController
    before_action :set_user, only: [:show, :destroy, :add_friend]
    before_action :block_not_adm, only: :destroy

    def block_not_adm
        if user_signed_in?
            redirect_to profile_path(current_user.id)
        else
            redirect_to new_user_session_path
        end
    end

    def add_friend
        if Friend.where(asker_id: current_user.id, replyer_id: @user.id).count() == 0
            Friend.create(asker_id: current_user.id, replyer_id: @user.id)
            Friend.create(asker_id: @user.id, replyer_id: current_user.id)
        end
    end

    def destroy
        @user.destroy
        redirect_to profiles_path
    end

    def index
        @users = if params[:term]
            User.where("name LIKE (?)",
            "%#{params[:term]}%").paginate(page: params[:page], per_page: 10)
        else
          User.paginate(page: params[:page], per_page: 6)
        end
    end

    def show
        @friends = Friend.where(asker_id: @user.id)
        @is_friend = Friend.where(asker_id: current_user.id, replyer_id: @user.id).count()
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end
end
