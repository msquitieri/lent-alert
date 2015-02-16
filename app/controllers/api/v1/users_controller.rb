class Api::V1::UsersController < Api::V1::ResourceController

  private

  def resource
    User
  end

  def permit_params
    [:email]
  end

end
