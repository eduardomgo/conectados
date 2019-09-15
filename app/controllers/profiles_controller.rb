class ProfilesController < ApplicationController
    before_action :set_user, only: [:show, :destroy]
    before_action :block_not_adm, only: [:destroy, :index]

    def block_not_adm
        if user_signed_in?
            redirect_to profile_path(current_user.id)
        else
            redirect_to new_user_session_path
        end
    end

    def destroy
        @user.destroy
        redirect_to profiles_path
    end

    def index
        @users = User.all
    end

    def show
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
