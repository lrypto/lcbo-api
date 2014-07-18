class API::V2::Manager::AccountsController < API::V2::Manager::ManagerController
  skip_before_filter :authenticate!, only: :create

  def show
    render_json current_user
  end

  def create
    user = User.create(create_user_params)
    respond_with :api, :v2, :manager, user,
      location: api_v2_manager_account_url,
      serializer: serializer
  end

  def update
    current_user.update(update_user_params)
    respond_with :api, :v2, :manager, current_user,
      location: api_v2_manager_account_url,
      serializer: serializer
  end

  def destroy
    user = current_user
    user.destroy
    respond_with :api, :v2, :manager, user
  end

  protected

  def create_user_params
    params.require(:account).permit(
      :name,
      :email,
      :password
    )
  end

  def update_user_params
    params.require(:account).permit(
      :name,
      :email,
      :current_password,
      :new_password
    )
  end

  def serializer
    API::V2::Manager::AccountSerializer
  end
end