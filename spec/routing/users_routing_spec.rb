require 'rails_helper'

RSpec.describe UsersController, :type => :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/users').to route_to('users#index')
    end

    it 'routes to #index' do
      expect(get: '/users/1').to route_to('users#show', id: '1')
    end

    it 'routes to #follows' do
      expect(get: '/users/1/follows').to route_to('users#follows', id: '1')
    end

    it 'routes to #followers' do
      expect(get: '/users/1/followers').to route_to('users#followers', id: '1')
    end
  end
end
