class V1::UsersController < V1::BaseController
  skip_before_action :authenticate!, only: [:login]

  def index
    render json: User.all, each_serializer: V1::UserSerializer
  end

  def expenses
    render json: @current_user.expenses, each_serializer: V1::ExpenseSerializer
  end

  def login
    user_params = params[:user]
    user = User.where(email: user_params[:email]).first
    unless user and user.valid_password?(user_params[:password])
      render json: { message: "Invalid credentials"}, status: 401
    else
      render json: { email: user.email, api_key: user.generate_api_key }
    end
  end
end
