class CallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
        @user = User.from_omniauth(request.env["omniauth.auth"])
        sign_in_and_redirect @user
    end

    private

      def sign_up_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :linked_in_url, :referrer_id, :prof_pic_url)
      end

end
