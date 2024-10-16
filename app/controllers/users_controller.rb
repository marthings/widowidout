class UsersController < ApplicationController
  def edit
    @user = User.includes(:counters).find(Current.user.id)
  end

  def update
    @user = Current.user
    if @user.update(user_params)
      redirect_to edit_users_path, notice: "Profile successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation, :avatar)
  end

end
