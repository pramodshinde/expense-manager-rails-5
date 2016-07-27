class V1::ExpensesController < V1::BaseController
  def index
    render json: Expense.all, each_serializer: V1::ExpenseSerializer
  end
end
