class UsersController < ApplicationController
  def index
    @users = [
        User.new(
                id: 1,
                name: 'Vadim',
                username: 'installero',
                avatar_url: 'https://secure.gravatar.com/avatar/71269686e0f757ddb4f73614f43ae445?s=100'
        ),
        User.new(
                id: 2,
                name: 'Misha',
                username: 'aristofun'
        )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://secure.gravatar.com/avatar/71269686e0f757ddb4f73614f43ae445?s=100'
    )

    @questions = [
        Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016')),
        Question.new(text: 'В чем смысл жизни?', created_at: Date.parse('27.03.2016'))
    ]

    @new_question = Question.new

    @question_count = sklonyator(@questions.length, 'вопрос', 'вопроса', 'вопросов', true)
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
