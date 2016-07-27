class Expense
  include Mongoid::Document
  field :name, type: String
  field :amount, type: Float

  belongs_to :user
end
