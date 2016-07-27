class V2::ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :amount, :name
  belongs_to :user
end
