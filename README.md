###Приложение "Askme"

Приложение на Rails - аналог ask.fm. Пользователи могут задавать вопросы другим зарегистрированным пользователям, а также отвечать на вопросы, адресованные им.

Для запуска требуется Ruby 2.3.0 или выше, Rails 4.2.6. Перед запуском требуется выполнить `bundle install` и `rake db:migrate`.

Использует jQuery, Google Captcha

В окружении Production: Настроение на использование Heroku и PostgreSQL.

В окружении Development: Использование SQLite.

Используемые гемы:

````
gem 'rails', '4.2.6'
gem 'jquery-rails'
gem 'recaptcha', require: 'recaptcha/rails'

group :production do
  gem 'pg'
  gem 'uglifier'
end

group :development, :test do
  gem 'byebug'
  gem 'sqlite3'
end

group :development do
  gem 'web-console', '~> 2.0'

end
````