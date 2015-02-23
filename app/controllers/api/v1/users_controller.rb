class Api::V1::UsersController < Api::V1::ResourceController

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
      respond_with :api, :v1, user
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

end
