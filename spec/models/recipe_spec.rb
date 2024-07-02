require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:post) { create(:post) }

  it "画像の拡張子が利用できる拡張子の場合は保存ができる" do

  end
  context "入力フォームのバリデーションのテスト" do
    it "レシピの作り方が空の場合はバリデーションエラーが出る" do
      recipe = build(:recipe, instructions: nil, post: post)
      expect(recipe).not_to be_valid
      expect(recipe.errors[:instructions]).to include("を入力してください")
    end
    it "画像の拡張子が利用できない拡張子の場合はバリデーションエラーが出る" do

    end
  end

  context "拡張子のバリデーションエラーのテスト" do
    it "jpeg/pngの拡張子の場合は保存される" do
      
      recipe.valid?
      expect(recipe.errors[:recipe_image]).not_to include("はjpegまたはpng形式の画像のみアップロードできます")
    end

    it "jpeg/pngの拡張子以外はバリデーションエラーが出る" do
      post.complete_image.attach(io: File.open('path/to/invalid_image.gif'), filename: 'invalid_image.gif', content_type: 'image/gif')
      post.valid?
      expect(post.errors[:recipe_image]).to include("はjpegまたはpng形式の画像のみアップロードできます")
    end
  end
end