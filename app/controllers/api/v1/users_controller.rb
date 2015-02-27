class Api::V1::UsersController < Api::V1::ResourceController

  before_action :set_user, only: [:destroy_with_contact_info]

  attr_reader :user

  def create
    time = Time.parse(params[:selected_time]).in_time_zone(params[:time_zone]).utc
    hour = time.hour
    minute = time.strftime('%M').to_i

    user_object = {
      alert_hour: hour,
      alert_minute: minute,
      time_zone: params[:time_zone]
    }

    contact_info = (params[:contact_type] == 'email') ? :email : :phone_number
    user_object[contact_info] = params[:contact_info]

    user = User.new(user_object)
    if user.save
      render json: { user: user }
    else
      render_message(:error, 422, user.errors.full_messages.join(', ').downcase)
    end
  end

  def destroy_with_contact_info
    if user.destroy
      render_message(:user, 200, "User successfully destroyed.")
    else
      render_message(:error, 422, user.errors.full_messages.join(', ').downcase)
    end
  end

  private

  def resource
    User
  end

  def permit_params
    [:email, :time_zone, :phone_number, :hour, :minute]
  end

  def set_user
    contact_info = (params[:contact_type] == 'email') ? :email : :phone_number
    if contact_info == :email
      @user = User.where(email: params[:contact_info]).first
    else
      number = PhonyRails.normalize_number(params[:contact_info], :country_code => 'US')
      @user = User.where(phone_number: number).first
    end

    render_message(:error, 404, "That user does not exist.") if @user.nil?
  end

end
