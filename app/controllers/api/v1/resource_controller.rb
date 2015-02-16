class Api::V1::ResourceController < Api::V1::ApiController
  respond_to :json

  before_action :set_object, only: [:show, :update, :destroy]

  attr_accessor :object

  def index
    if params[:ids].present? and params[:ids].is_a? Array
      objects = resource.where(id: params[:ids])
    else
      objects = resource.paginate(page: params[:page], per_page: params[:per_page])
    end

    respond_with objects
  end

  def show
    respond_with object
  end

  def create
    respond_with :api, :v1, resource.create(object_params)
  end

  def update
    respond_with object.update(object_params)
  end

  def destroy
    respond_with object.destroy
  end

  private

  def resource
    raise "All subclasses must write this method!!"
  end

  def set_object
    @object = resource.where(id: params[:id]).first
    render_object_not_found if @object.nil?
  end

  def object_params
    params.require(object_sym).permit(permit_params)
  end

  def object_sym
    resource.to_s.downcase.to_sym
  end

  def permit_params
    raise "All subclasses must write this method!!"
  end

  def render_object_not_found
    render_message(object_sym, 404, "#{resource.to_s} ID not recognized.")
  end

end