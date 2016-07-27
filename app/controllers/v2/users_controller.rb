class V2::UsersController < V1::UsersController
  def index
    render json: User.all, each_serializer: V2::UserSerializer
  end
end
