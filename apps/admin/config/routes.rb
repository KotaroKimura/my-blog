# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
resources :posts,  only: [:index, :create, :edit, :update, :destroy]
resources :images, only: [:create]
namespace 'images' do
  delete '/:name', to: 'images#destroy'
end

root to: 'posts#index'
