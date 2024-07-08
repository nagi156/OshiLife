require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:guest_user) { create(:guest_user) }

  describe "GET/edit" do
    context "ログインユーザーとして" do
      before  do
        sign_in user
      end
      it "自身の編集ページにアクセスできる" do
        get edit_user_path(user)
        expect(response).to have_http_status(:success)
      end
      it "他の人のプロフィール編集にアクセスできない" do
        get edit_user_path(other_user)
        expect(response).to redirect_to(my_page_path)
      end
    end

    context "ゲストユーザーとして" do
      before do
        sign_in guest_user
      end
      it "アクセスが制限される" do
        get edit_user_path(user)
        expect(response).to redirect_to(my_page_path)
      end
    end
    context "未ログインユーザーとして" do
      before do
        get edit_user_path(user)
      end
      it "サインインページにリダイレクトされる" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PACTH/update" do
    context "ログインユーザーとして" do
      before  do
        sign_in user
      end
      it "自身のプロフィールの編集ができる" do
        patch user_path(user), params: { user: { name: "Updated name" } }
        
        expect(response).to redirect_to(my_page_path)
        follow_redirect!
        
        expect(response.body).to include("Updated name")
        expect(response).to have_http_status(:ok)
      end
      
      it "他ユーザーのプロフィールは更新できない" do
        patch user_path(other_user), params: { user: { name: "Updated name" } }
        expect(response).to redirect_to(my_page_path)
      end
    end
    context "ゲストユーザーとして" do
      before do
        sign_in guest_user
      end
      it "アクセスが制限される" do
        patch user_path(user), params: { user: { name: "Updated name" } }
        expect(response).to redirect_to(my_page_path)
      end
    end
    context "未ログインユーザーとして" do
      before do
        patch user_path(user), params: { user: { name: "Updated name" } }
      end
      it "サインインページにリダイレクトされる" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
