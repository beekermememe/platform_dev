require 'rails_helper'

RSpec.describe AnagramsController, type: :controller do

  describe "GET #word" do
    it "returns http success" do
      get "word/super", format: :json
      expect(response).to have_http_status(:success)
    end
  end

end
