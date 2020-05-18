require 'rails_helper'

# TestControllerというコントローラーのテスト
RSpec.describe TestController, type: :controller do
  # indexメソッドがテスト対象
  describe '#index' do
    # 正常に応答する
    it 'responds successfully' do
      get :index
      expect(response).to be_success  
    end
  end

  # 200ステータスが帰ってくる
  it 'returns a 200 response' do
    get :index
    expect(response).to  have_http_status '200'
  end
end
