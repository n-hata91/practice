
require 'rails_helper'
  RSpec.describe PostsController, type: :controller do
    describe '新規投稿ページ' do
      context "新規投稿ページが正しく表示される" do
        before do
          get :new
        end
        it 'リクエストは200 OKとなること' do
          expect(response.status).to eq 200
        end
        render_views
        it 'タイトルが正しく表示されていること' do
          expect(response.body).to include("新規投稿")
        end
      end
    end
  end