class UsersController < ApplicationController

  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def edit
  end

  def update

    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные успешно обновлены!'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @question_count = sklonyator(@questions.length, 'вопрос', 'вопроса', 'вопросов', true)
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :username, :avatar_url)
  end

  def sklonyator (number, krokodil, krokodila, krokodilov, with_number = false)
    if number == nil || !number.is_a?(Numeric)
      number = 0
    end

    prefix = ''
    prefix = "#{number} " if with_number

    ostatok = number % 10
    ostatok100 = number % 100

    if ostatok100 >= 11 && ostatok100 <=14
      return "#{prefix}#{krokodilov}"
    elsif ostatok == 1
      return "#{prefix}#{krokodil}"
    elsif ostatok >= 2 && ostatok <= 4
      return "#{prefix}#{krokodila}"
    elsif ostatok > 4 || ostatok == 0
      return "#{prefix}#{krokodilov}"
    end
  end

end
