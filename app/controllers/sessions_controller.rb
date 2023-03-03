class SessionsController < Devise::SessionsController
    before_action :authenticate_2fa!, only: :create

    def authenticate_2fa!
        user = self.resource = find_user
        return unless user
        if user_params[:otp_attempt].present?
            auth_with_2fa(user)
        elsif user.valid_password?(user_params[:password]) && user.otp_required_for_login
            session[:user_id] = user.id
            CodeMailer.send_code(user).deliver_now
            return render "users_otp/two_fa"
        end
    end
    def find_user
        if session[:user_id]
            User.find_by(id: session[:user_id])
        elsif user_params[:email].present?
        User.find_by(email: user_params[:email])
        end
    end
    def auth_with_2fa(user)
        if user.validate_and_consume_otp!(user_params[:otp_attempt])
            user.save!
            sign_in(user)
            redirect_to root_path
        else
            flash[:error] = "Invalid OTP"
            redirect_to new_user_session_path
        end
    end
    private
    def user_params
        params.fetch(:user, {}).permit(:otp_attempt, :password, :email, :remember_me)
    end
    end

