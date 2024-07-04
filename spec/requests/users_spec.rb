require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:guest_user) { create(:guest_user) }
  let(:genre) { create(:genre) }

  describe "GET/edit" do
    context "ログインユーザーとして" do
      before  do
        sign_in user
        get edit_user_path(user)
      end
      it "編集ページにアクセスできる" do
        expect(response).to have_http_status(:success)
      end
    end

    context "ゲストユーザーとして" do
      before do
        sign_in guest_user
        get edit_user_path(user)
      end
      it "アクセスが制限される" do
        expect(response).to redirect_to(my_page_path)
        follow_redirect!
        expect(response.body).to include("閲覧のみ可能です。ご利用の際はご登録してご利用ください。")
      end
    end
    context "未ログインユーザーとして" do
      it "サインインページにリダイレクトされる" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PACTH/update" do
    context "ログインユーザーとして" do
      before  do
        sign_in user
        patch user_path(user), params: { user: { name: "Updated name" } }
      end
      it "編集ができる" do
        expect(response).to redirect_to(my_page_path)
        follow_redirect!
        expect(response.body).to include("編集しました。")
      end
    end
    context "ゲストユーザーとして" do
      before do
        sign_in guest_user
        patch user_path(user), params: { user: { name: "Updated name" } }
      end
      it "アクセスが制限される" do
        expect(response).to redirect_to(my_page_path)
        follow_redirect!
        expect(response.body).to include("閲覧のみ可能です。ご利用の際はご登録してご利用ください。")
      end
    end
    context "未ログインユーザーとして" do
      it "サインインページにリダイレクトされる" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
