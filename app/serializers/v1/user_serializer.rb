class V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :email

  has_many :expenses
end
