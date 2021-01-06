class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])  #paramsで:idパラメータを受け取る(/users/1にアクセスしたら1を受け取る)。DBからid:1のレコードをfindメソッドで取り出す
  end

  def new
  end
end