## Стена сообщений пользователей

### Web-приложение для просмотра/создания/комментирования сообщений.

#### Список функций и возможностей:
 - вход с систему с помощью социальных сетей Вконтакте и Facebook;
 - просмотр списка сообщений на стене;
 - добавление новых сообщений на стену;
 - редактирование собственных сообщений;
 - просмотр комментариев для сообщений;
 - добавление комментариев;
 - редактирование собственных комметариев;
 - мгновенное отображение сообщений;
 - Infinity scroll.

#### Установка:
```bash
$ git clone https://github.com/VitaHub/wall_of_messages.git
$ cd wall_of_messages
$ bundle install
$ rake db:migrate
$ rake db:seed
$ rails s # запуск локального сервера на localhost:3000
# Для мгновенного отображения сообщений без перезагрузки нужно 
# запустить Faye в отдельной вкладке коммандной строки:
$ rackup sync.ru -E production # запуск Faye сервера
```
Теперь веб-приложение будет доступно по адресу: 'localhost:3000'

#### Описание:
Приложение состоит из двух страниц: страницы входа ("/") и  страницы сообщений ("/messages"). При попадании на страницу входа пользователю представляется возможность войти на сайт с помощью социальных сетей Вконтакте или Facebook. Если пользователь будет входить от разных социальных сетей, которые зарегистрированы на одном почтовом ящике, новый аккаунт повторно создаваться не будет. После входа в систему пользователь будет перенаправлен на страницу сообщений. При попытке перейти на страницу входа пользователь будет все равно перенаправлен на страницу сообщений.

Пользователь может отправлять сообщения или комментарии по нажатию Ctrl+Enter. Для редактирований сообщений, отправления/редактирования комментариев появляется модальное окно. По умолчанию все комментарии скрыты, но есть возможность их отобразить нажатием на иконку возле автора сообщения. После отправления/редактирования сообщения или комментария оно мгновенно появляется/обновляется у всех пользователей без перезагрузки страницы. При загрузке списка сообщений будет отображено только 10 последних сообщений, но при прокрутке вниз остальные сообщений будут подгружаться (реализация Infinity scroll).

Страницу сообщений пользователь может просматривать даже без входа в систему, но в таком случае он лишается возможности отправлять/редактировать сообщений или комментарии и вместо формы отправки сообщений будут ссылки для входа.
