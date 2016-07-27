Rails.application.routes.draw do
  
  api_version(
    module: "V2", 
    header: { name: "Accept", value: "application/vnd.expense-manager.com; version=2" }
  ) do
    resources :users 
    resources :expenses
  end
  
  api_version(
    module: "V1", 
    header: { name: "Accept", value: "application/vnd.expense-manager.com; version=1" },
    default: true
  ) do
    resources :users
    resources :expenses
  end
end
