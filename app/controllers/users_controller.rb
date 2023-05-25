class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
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
            def admin_only
                unless current_user.admin?
                  redirect_to root_path, :alert => "Access denied."
                end
              end
end
