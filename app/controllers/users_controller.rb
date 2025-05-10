class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only!

  def index
    @users = User.where(company_id: current_user.company_id)
  end

  private

  def admin_only!
    return if current_user.admin?

    redirect_to root_path, alert: '管理者のみアクセスできます。'
  end
end
