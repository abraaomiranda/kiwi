require 'rails_helper'

RSpec.describe FollowsController, :type => :routing do
  describe 'routing' do

    it 'routes to #create' do
      expect(post: '/posts').to route_to('follows#create')
    end

    it 'routes to #destroy' do
      expect(delete: '/posts/1').to route_to('follows#destroy', id: '1')
    end
  end
end
