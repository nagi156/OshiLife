require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { build(:post) }
  let(:genre) { create(:genre) }

  it "有効な投稿内容の場合は保存されるか" do
    expect(post).to be_valid
  end

  context "入力フォームのバリデーションのテスト" do
    it "タイトルが空の時、保存されないか" do
      post.title = nil
      expect(post).not_to be_valid
    end
    it "ジャンルが選択されていない時、保存されないか" do
      post.genre = nil
      expect(post).not_to be_valid
    end
  end

  context "拡張子のバリデーションエラーのテスト" do
    it "jpeg/pngの拡張子の場合は保存される" do
      post.valid?
      expect(post.errors[:complete_image]).not_to include("はjpegまたはpng形式の画像のみアップロードできます")
    end

    it "jpeg/pngの拡張子以外はバリデーションエラーが出る" do
      post.complete_image.attach(io: StringIO.new("invalid binary data"), filename: 'invalid_image.gif', content_type: 'image/gif')
      post.valid?
      expect(post.errors[:complete_image]).to include("はjpegまたはpng形式の画像のみアップロードできます")
    end
  end


end