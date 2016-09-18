# LoginController
class LoginController < ApplicationController
  skip_before_action :find_authenticated_user, only: :login

  # GET /
  def index
    @authenticated_user = User.new
  end

  # POST /login
  def login
    if try_to_login(login_params[:email], login_params[:password])
      save_authenticated_user_id(@authenticated_user.id)
      redirect_to('/', notice: 'thanks nigga')
    else
      @authenticated_user = User.new(login_params)
      render(:index, error: 'no good nigga')
    end
  end

  # GET /logout
  def logout
    remove_authenticated_user
    redirect_to(signin_path)
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
end
