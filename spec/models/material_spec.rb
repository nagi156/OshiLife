require 'rails_helper'

RSpec.describe Material, type: :model do
  let(:post) { create(:post) }

  it "材料名が空の場合はバリデーションエラーが出る" do
    material = build(:material, name: nil, post: post)
    expect(material).not_to be_valid
    expect(material.errors[:name]).to include("を入力してください")
  end

end