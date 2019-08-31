require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path(__dir__)
end

require_relative "config/application"

set :views, (proc { File.join(root, "app/views") })
set :bind, '0.0.0.0'



get '/' do
  # TODO
  # 1. fetch posts from database.
  # 2. Store these posts in an instance variable
  # 3. Use it in the `app/views/posts.erb` view
  @posts = Post.all.order(votes: :desc)

  erb :posts # Do not remove this line
end

# TODO: add more routes to your app!

post '/new_post' do
  Post.create(name: params[:name], url: params[:url])

  redirect '/'
end

get '/upvote_post' do
  post = Post.find(params[:id])
  post.votes += 1
  post.save

  redirect '/'
end


