require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let(:user) { create(:user) }
  let(:guest_user) { create(:guest_user) }
  let(:genre) { create(:genre) }

  describe "POST /posts" do
    context "ログインユーザーとして" do
      before do
        sign_in user
      end

      it "有効な属性で投稿を作成できる" do
        post_params = {
          post: {
            title: "テストタイトル",
            genre_id: genre.id,
            materials_attributes: [
              { name: "Material 1", amount: "1" },
              { name: "Material 2", amount: "2" }
            ],
            recipes_attributes: [
              { instructions: "Recipe 1" },
              { instructions: "Recipe 2" }
            ]
          }
        }
        expect {
          post posts_path, params: post_params
        }.to change(Post, :count).by(1)
        expect(response).to redirect_to(post_path(Post.last))
      end
    end

    context "ゲストユーザーとして" do
      before do
        sign_in guest_user
        allow(request).to receive(:referer).and_return(root_path)
      end

      it "新規投稿ができない" do
        post_params = {
          post: {
            title: "テストタイトル",
            genre_id: genre.id,
            materials_attributes: [
              { name: "Material 1", amount: "1" },
              { name: "Material 2", amount: "2" }
            ],
            recipes_attributes: [
              { instructions: "Recipe 1" },
              { instructions: "Recipe 2" }
            ]
          }
        }
        expect {
          post posts_path, params: post_params
        }.not_to change(Post, :count)
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('閲覧のみ可能です。ご利用の際はご登録してご利用ください。')
      end

      it "新規投稿ページにアクセスできない" do
        get new_post_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('閲覧のみ可能です。ご利用の際はご登録してご利用ください。')
      end
    end

    context "未ログインユーザーとして" do
      it "新規投稿ができない" do
        post_params = {
          post: {
            title: "テストタイトル",
            genre_id: genre.id,
            materials_attributes: [
              { name: "Material 1", amount: "1" },
              { name: "Material 2", amount: "2" }
            ],
            recipes_attributes: [
              { instructions: "Recipe 1" },
              { instructions: "Recipe 2" }
            ]
          }
        }
        expect {
          post posts_path, params: post_params
        }.not_to change(Post, :count)
        expect(response).to redirect_to(new_user_session_path)
      end

      it "新規投稿ページにアクセスできない" do
        get new_post_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /edit" do
    let(:other_user) { create(:user) }
    let(:user_post) { create(:post, user: user) }
    let(:other_post) { create(:post, user: other_user) }

    context "ログインユーザーの場合" do
      before do
        sign_in user
      end

      it "自分投稿の編集ページにアクセスできる" do
        get edit_post_path(user_post)
        expect(response).to have_http_status(:success)
      end
      it "他のユーザーの投稿の編集ページにアクセスできない。" do
        get edit_post_path(other_post)
        expect(response).to redirect_to(posts_path)
      end

    end

    context "ゲストユーザーの場合" do
      before do
        sign_in guest_user
      end
      it "アクセスできない。" do

      get edit_post_path(user_post)
        expect(response).to redirect_to(posts_path)
      end
    end

    context "未ログインユーザーの場合" do
      before do
        get edit_post_path(user_post)
      end

      it "サインインページにリダイレクトされる" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PATCH /update" do
    let(:other_user) { create(:user) }
    let(:user_post) { create(:post, user: user) }
    let(:other_post) { create(:post, user: other_user) }

    context "ログインユーザーの場合" do
      before do
        sign_in user
      end

      it "自身の投稿が編集して更新できる" do
        patch post_path(user_post), params: {
          post: {
            title: "Updated Title"
            }
          }

      expect(response).to redirect_to(post_path(user_post))
      follow_redirect!

      expect(response.body).to include("Updated Title")
      expect(response).to have_http_status(:ok)
    end

      it "他ユーザーの投稿の編集して更新はできない" do
        patch post_path(other_post), params: { post: { title: "Updated Title" } }
        expect(response).to redirect_to(posts_path)
      end
    end

    context "ゲストユーザーの場合" do
      before do
        sign_in guest_user
        patch post_path(user_post), params: { post: { title: "Updated Title" } }
      end

      it "アクセスが制限される" do
        expect(response).to redirect_to(posts_path)
      end
    end

    context "未ログインユーザーの場合" do
      before do
        patch post_path(user_post), params: { post: { title: "Updated Title" } }
      end

      it "サインインページにリダイレクトされる" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "Delete/destroy" do
    let(:other_user) { create(:user) }
    let(:user_post) { create(:post, user: user) }
    let(:other_post) { create(:post, user: other_user) }

    context "ログインユーザー" do
      before do
        sign_in user
      end

      it "自分の投稿を削除できる" do
        delete post_path(user_post)

        expect(response).to redirect_to(my_page_path)
        follow_redirect!

        expect(response).to have_http_status(:ok)
      end
      it "他ユーザーの投稿は削除できない" do
        delete post_path(other_post)
        expect(response).to redirect_to(my_page_path)
      end
    end

    context "ゲストユーザー" do
      before do
        sign_in guest_user
        delete post_path(user_post)
        allow(request).to receive(:referer).and_return(root_path)
      end
      it "アクセスできない" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "未ログインユーザー" do
      before do
        delete post_path(user_post)
      end
      it "サインイン画面にリダイレクト" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
