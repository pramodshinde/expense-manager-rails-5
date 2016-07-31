require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "V1" do
  let!(:user) { 
    User.create(
      email: "test1@test.com", 
      password: "josh123",
      password_confirmation: "josh123", 
    )
  }

  header "Accept", "application/vnd.expense-manager; version=1"
  header "Content-Type", "application/json"

  post "users/login" do

    parameter :user, "user's sign in params", required: :true, "Type" => "Hash"
    parameter :email, "User Email", required: true, "Type" => "String", scope: :user
    parameter :password, "User's password", required: true, "Type" => "String", scope: :user
   
    before do  
      @params = {
        user: {
          email: 'test1@test.com',
          password: "josh12"
        }
      }
    end

    let(:raw_post) {@params.to_json}
    example "Login: Returns Invalid credentials" do
      do_request
      expect(JSON.parse(response_body)["message"]).to eq("Invalid credentials")
      expect(status).to eq 401
    end

    example "Login: Returns API key on success" do
      @params[:user][:password] = "josh123"
      do_request
      expect(JSON.parse(response_body)["email"]).to eq(user.email)
      expect(JSON.parse(response_body)["api_key"]).not_to be_blank
      expect(status).to eq 200
    end
  end
end
