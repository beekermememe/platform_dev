require 'rails_helper'

RSpec.describe AnagramsController, type: :controller do

  describe "GET #read" do
    it "returns http success" do
      get :read
      expect(response).to have_http_status(:success)
    end
  end

end
