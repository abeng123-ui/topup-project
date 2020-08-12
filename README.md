# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
Rails 6.0.3.2

* System dependencies
For Windows,
- install rubyinstaller-devkit-2.5.1-1-x64
- install XAMPP, run Mysql Server

* Configuration
At this Repo, configure database environment with edit file .ENV, example :
## MAIN_DB_DEV_HOST=127.0.0.1
## MAIN_DB_DEV_DB_NAME=topupproject_development
## MAIN_DB_DEV_USERNAME=root
## MAIN_DB_DEV_PASSWORD=

* Database creation
Open cmd terminal, change directory to this repo location, example C:/TopupProject, run this command :
rails db:create
rails db:migrate

* Database initialization

* Deployment instructions
 rails server -p 8080
