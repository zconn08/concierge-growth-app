class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @user = User.new(user_params)
    Event.create(event_type: "Sign Up Button Clicked", referral_id: params["referral_id"])
    if @user.save
      Event.create(event_type: "User Signed Up", referral_id: params["referral_id"], user_id: @user.id)
      redirect_to action: "show", id: @user.id
    else
      render json: @user.errors.full_messages
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    super
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :linked_in_url, :referrer_id)
    end
end
