# Log Watcher

Ruby on rails implementation of a log watching solution (similar to the tail -f command) using websockets

* Ruby version: 3.4.1
* Rails version 7.2.2

To run the project -
* Fork and clone the repo
* cd into the project directory
* run `bundle install`
* run `bin/rails db:migrate`
* create a dummy.log file inside log directory (fill with some logs if you may)
* run rails s
* watch last 10 logs and as you enter contents into the file