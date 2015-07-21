get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/api/v1/users' do
  @users = User.all
  @users.to_json
end

get '/api/v1/users/:user_id/articles' do
  #@user_articles = Article.where(user_id: params[:user_id])
  @articles = User.find(params[:user_id]).articles
  p @articles
  p "*" * 120
  @articles.to_json
end

post 'api/v1/users/:user_id/articles/:api_key' do
  new_article = Article.new(user_id: params[:user_id], title: params[:title], body: params[:body])
  api_key = params[:api_key]
  api_key_nil?(api_key)
  if new_article.save && !api_key_nil?(api_key)
    increase_counter(:api_key)
    status 201
  elsif api_key_nil?(api_key)
    status 401
  else
    status 422
    # new_article.errors.full_messages.to_json
  end
end

post 'api/v1/users/:user_id/articles/:article_id/comments/:api_key' do
  comment = Comment.new(user_id: params[:user_id], article_id: params[:article_id], body: params[:body])
  api_key = params[:api_key]
  if comment.save && !api_key_nil?(api_key)
    increase_counter(:api_key)
    status 201
  elsif api_key_nil?(api_key)
    status 401
  else
    status 422
  end
end

post 'api/v1/users/:user_id/api_key' do
  new_key = Key.new(user_id: params[:user_id], api_key: SecureRandom.hex)
  if new_key.save
    status 201
  else
    status 422
  end
end









