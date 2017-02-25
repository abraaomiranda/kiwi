require 'rails_helper'

RSpec.describe Feed, type: :model do
  let(:user) { create(:user) }
  let(:followed_user) { create(:follow, follower: user).followed }
  let(:feed) { Feed.new(user) }

  describe '#posts' do
    it 'return posts from current user' do
      post = create(:post, author: user)

      expect(feed.posts).to include post
    end

    it 'return posts from a followed user' do
      post = create(:post, author:followed_user)

      expect(feed.posts).to include post
    end

    it 'not return posts form not followed users' do
      create(:post)

      expect(feed.posts).to be_empty
    end

  end
end
