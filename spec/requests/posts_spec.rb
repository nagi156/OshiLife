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
    context "ログインユーザーの場合" do
      before do
        sign_in user
        visit edit_post_path(post)
      end

      it "編集ページにアクセスできる" do
        expect(response).to have_http_status(:success)
      end
    end

    context "ゲストユーザーの場合" do
      before do
        sign_in guest_user
        get edit_post_path(post)
      end
      it "アクセスできない。" do
        
      get new_post_path
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include('閲覧のみ可能です。ご利用の際はご登録してご利用ください。')
      end
    end

    context "未ログインユーザーの場合" do
      before do
        get edit_post_path(post)
      end

      it "サインインページにリダイレクトされる" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "PATCH /update" do
    context "ログインユーザーの場合" do
      before do
        sign_in user
        patch post_path(post), params: { post: { title: "Updated Title" } }
      end

      it "投稿が更新される" do
        expect(response).to redirect_to(post_path(post))
        follow_redirect!
        expect(response.body).to include("Updated Title")
      end
    end

    context "ゲストユーザーの場合" do
      before do
        sign_in guest_user
        patch post_path(post), params: { post: { title: "Updated Title" } }
      end

      it "アクセスが制限される" do
        expect(response).to redirect_to(request.referer || root_path)
        follow_redirect!
        expect(response.body).to include("閲覧のみ可能です。ご利用の際はご登録してご利用ください。")
      end
    end

    context "未ログインユーザーの場合" do
      before do
        patch post_path(post), params: { post: { title: "Updated Title" } }
      end

      it "サインインページにリダイレクトされる" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
