class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save                        #保存に成功した場合
      log_in @user
      flash[:success] = "ようこそ!!"      #flash=登録完了後のみウェルカムメッセージは表示させ、リロードしたら消えるようにする
      redirect_to @user                  #リダイレクト redirect_to user_url(@user)→redirect_to user_url(id: @user.id)
    else
      render 'new'                       #保存が失敗したらnewビューへ戻す
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end

