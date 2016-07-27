class V2::UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :total_expenses

  def total_expenses
    object.expenses.sum(:amount)
  end
end
