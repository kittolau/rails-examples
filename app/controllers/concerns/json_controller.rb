class GlobalScopeProfilesController < ApplicationController

  def index
    @models = GlobalScopeProfile.all.page(params[:page]).per(params[:itemsPerPage])
    response.headers['total_count'] = @models.total_count.to_s
    render json: @models
  end

  def show
    @model = GlobalScopeProfile.find(params[:id])
    render json: @model
  end

  def new
    @model = GlobalScopeProfile.new

  end

  def create
    @model = GlobalScopeProfile.new(scope_params)
    if @model.save
      render json: @model, status: :created
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  def edit
    @model = GlobalScopeProfile.find(params[:id])
  end

  def update
    @model = GlobalScopeProfile.find(params[:id])
    if @model.update_attributes(scope_params)
      render nothing: true, status: :no_content
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @model = GlobalScopeProfile.find(params[:id])
    @model.destroy
    render nothing: true
  end

  def scope_params
    params.require(:global_scope_profile).permit(:profile_name, :begin_from, :end_to,:end_to_now,:begin_from_ago, post_sources_settings_lists: [] )
  end
end
