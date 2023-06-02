class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only
  after_action :enable_otp, only: [:create]
  before_action :set_user, only: %i[ show edit update destroy ]

    def index
        @users = User.all
    end
    def edit
    end

      def confirm_password_user
        user = User.find_by(id: params[:id])

        if current_user.valid_password?(params[:password])
          # Password matches
          # Perform the desired action (e.g., delete user)
          user.destroy
          redirect_to users_path, notice: "User successfully deleted."
        else
          # Password doesn't match
          redirect_to users_path, alert: "Incorrect password."
        end
      end
      def confirm_password_client
        client = Client.find_by(id: params[:id])

        if current_user.valid_password?(params[:password])
          # Password matches
          # Perform the desired action (e.g., delete user)
          client.destroy
          redirect_to clients_path, notice: "Client successfully deleted."
        else
          # Password doesn't match
          redirect_to clients_path, alert: "Incorrect password."
        end
      end
      def confirm_password_equipment
        equipment = Equipment.find_by(id: params[:id])

        if current_user.valid_password?(params[:password])
          # Password matches
          # Perform the desired action (e.g., delete user)
          equipment.destroy
          redirect_to equipment_index_path, notice: "Equipment successfully deleted."
        else
          # Password doesn't match
          redirect_to equipment_index_path, alert: "Incorrect password."
        end
      end
      def update
        params = user_params
        if params[:password].blank? && params[:password_confirmation].blank?
          params.delete(:password)
          params.delete(:password_confirmation)
      end

      if params[:current_password].present?
        if current_user.valid_password?(params[:current_password])
          params.delete(:current_password)
            if @user.update(params)
              redirect_to users_path, notice: "User was successfully updated."
            else
              redirect_to edit_user_path(@user), alert: "Something went wrong"
            end
          else
            redirect_to edit_user_path(@user), alert: "Password is incorrect"
          end
        else
          redirect_to edit_user_path(@user), alert: "Please enter your current password"
        end
      end

      def new
        @user = User.new
      end

      def create
        @user = User.new(user_params)
        respond_to do |format|
          if @user.save
            format.html { redirect_to  users_path, notice: "user was successfully created." }
          else
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end

      def destroy
        @user.destroy

        respond_to do |format|
          format.html { redirect_to users_path, notice: "user was successfully destroyed." }
          format.json { head :no_content }
        end
      end

      private
        def user_params
            params.require(:user).permit(:email, :name, :birthday,  :password, :password_confirmation, :admin, :phone_number, :current_password)
            end

          def admin_only
                unless current_user.admin?
                  redirect_to root_path, :alert => "Access denied."
                end
          end

          def enable_otp
            puts @user
            @user.otp_required_for_login = true
            @user.otp_secret = User.generate_otp_secret
            @user.save!
          end

          def set_user
            @user = User.find(params[:id])
          end

end
