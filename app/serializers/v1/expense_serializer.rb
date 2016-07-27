class V1::ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :amount, :name
  belongs_to :user
end
