require 'rails_helper'

Rspec.describe Post, type: :model do
  let(:post) { build(:post) }

  it "有効な投稿内容の場合は保存されるか" do
    expect(post).to be_valid
  end

  context "バリデーションのテスト" do
    it "タイトルが空の時、保存されないか" do
      post.title = nil
      expect(post).not_to be_valid
    end
    it "ジャンルが選択されていない時、保存されないか" do
      post.genre = nil
      expect(post).not_to be_valid
    end
    it "材料が空の時、保存されないか" do
      post.material = []
      expect(post).not_to be_valid
    end
    it "作り方が空の時、保存されないか" do
      post.recipe = []
      expect(post).not_to be_valid
    end
  end
end