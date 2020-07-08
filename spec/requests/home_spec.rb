require 'rails_helper'

RSpec.describe 'home', type: :request do
  it 'GET #index が正常に表示される' do
      get root_path
      expect(response).to have_http_status 200
  end
  
  it 'GET #aboutが正常に表示される' do
      get about_path
      expect(response).to have_http_status 200
  end
end