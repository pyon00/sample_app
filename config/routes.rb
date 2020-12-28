Rails.application.routes.draw do
  get '/signup',  to:'users#new'

  root 'static_pages#home'
  get '/help',    to: 'static_pages#help'
  get '/about',   to:'static_pages#about'
  get '/contact', to:'static_pages#contact'
  
end

#URLを名前付きルートを定義した（扱いやすくなるので）

#'static_pages/home'
#名前付きルート↓も使えるようにGETルールに変更する、と
#'/home',    to:'static_pages#home'となる

#root_path -> '/' ルート以下の文字列
#root_url  -> 'http://www.example.com/' 全URL
#基本的には_path書式を使い、リダイレクトの場合のみ_url書式を使うようにします
