class Api::V1::ApiController < ApplicationController
 skip_before_action :verify_authenticity_token

 def render_message(head, status_code, message)
  render json: { head => {message: message} }, status: status_code
 end

end