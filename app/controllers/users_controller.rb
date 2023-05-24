class UsersController < ApplicationController
    def index
        @users = User.all
    end
    def edit
        @user = User.find(params[:id])
      end


      def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          redirect_to root_path
        else
          render 'edit'
        end
      end

      private
        def user_params
            params.require(:user).permit(:name, :birthday, :phone_number,  :email)
            end
end
