class ProfilesController < ApplicationController
    before_action :set_user, only: [:cancel_friendship, :destroy_friendship, :accept_friendship, :friends, :show, :destroy, :add_friend]
    before_action :block_not_adm, only: :destroy
    before_action :block_non_logged

    def block_not_adm
        if user_signed_in?
            redirect_to profile_path(current_user.id)
        else
            redirect_to new_user_session_path
        end
    end
    
    def accept_friendship
        @friend = Friend.find_by(replyer_id: @user.id, asker_id: current_user.id)
        puts @user.id, current_user.id
        @friend.accepted = true
        @friend.save
        redirect_to friends_path(current_user.id)
    end
    
    def cancel_friendship
        @friend = Friend.find_by(asker_id: @user.id, replyer_id: current_user.id)
        @friend2 = Friend.find_by(asker_id: current_user.id, replyer_id: @user.id)
        @friend.destroy
        @friend2.destroy
        redirect_to profile_path(@user.id)
    end

    def destroy_friendship
        @friend = Friend.find_by(asker_id: @user.id, replyer_id: current_user.id)
        @friend2 = Friend.find_by(asker_id: current_user.id, replyer_id: @user.id)
        @friend.destroy
        @friend2.destroy
        redirect_to friends_path(current_user.id)
    end

    def friends
        @friend_asks = Friend.where(asker_id: @user.id, accepted: false)
        @friends = friendships(@user)
    end

    def add_friend
        if Friend.where(asker_id: current_user.id, replyer_id: @user.id).count() == 0
            Friend.create(asker_id: current_user.id, replyer_id: @user.id, accepted: true)
            Friend.create(asker_id: @user.id, replyer_id: current_user.id)
        end
        redirect_to profile_path(@user.id)
    end

    def show
        @posts = Post.where(user_id: @user.id)
        @friends = Friend.where(asker_id: @user.id)
        @is_friend = Friend.where(asker_id: current_user.id, replyer_id: @user.id).count()
    end
    

    def destroy
        @user.destroy
        redirect_to profiles_path
    end

    def index
        @users = if params[:term]
            User.where("name LIKE (?)", "%#{params[:term]}%").paginate(page: params[:page], per_page: 10)
        else
          User.paginate(page: params[:page], per_page: 10)
        end
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
