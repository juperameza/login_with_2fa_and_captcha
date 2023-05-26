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

      def new
        @user = User.new
      end

      def create
        puts(user_params)
        @user = User.create!(user_params)

        respond_to do |format|
          if @user.save
            format.html { redirect_to  user_path, notice: "user was successfully created." }
          else
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end
      private
        def user_params
            params.require(:user).permit(:email, :name, :birthday,  :password, :password_confirmation, :admin)
            end

          def admin_only
                unless current_user.admin?
                  redirect_to root_path, :alert => "Access denied."
                end
          end
end
