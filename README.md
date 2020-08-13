# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
- Rails 6.0.3.2
---
* System dependencies For Windows,
- install rubyinstaller-devkit-2.5.1-1-x64
- install XAMPP, run Mysql Server
---
* Configuration
Open cmd terminal, change directory to this repo location, example C:/TopupProject, run this command :
- gem install rails
- bundle install
---
* Database initialization
Configure database environment with duplicate .env-dist file, and rename to .env, after that edit it, example :
- MAIN_DB_DEV_HOST=127.0.0.1
- MAIN_DB_DEV_DB_NAME=topupproject_development
- MAIN_DB_DEV_USERNAME=root
- MAIN_DB_DEV_PASSWORD=
---
* Database creation
Open cmd terminal, change directory to this repo location, example C:/TopupProject, run this command :
- rails db:create
- rails db:migrate
- rails db:seed
---
* Deployment instructions
Open cmd terminal, change directory to this repo location, example C:/TopupProject, run this command :
- rails server -p 8080
---
* Simulasi Pretest
- Import Topup Project.postman_collection.json into Postman API Documentation

# 1. Buatlah CRUD dengan Full Rest Api dari schema database di atas .
- Eksekusi API dalam folder User untuk melakukan CRUD User
- Untuk Eksekusi CRUD User Balance dan lainnya, silahkan melakukan login pada API Login dalam folder login
- Setelah mendapat respon auth_token, copy isi dari auth_token, lalu isi Authorization pada header API yang ingin dites, dengan token tersebut
- User terbagi dalam 2 role, admin dan user, role admin mendapat akses ke semua API, dan role user hanya dapat melakukan login, transfer balance dan request topup (transaction)
- Alur transaksi sebagai berikut, setelah role User login, User melakukan request topup pada endpoint http://localhost:8080/transaction [POST], dan status pada tabel transaksi menjadi "process"
- Lalu setelah User melakukan transfer dana, Admin melakukan check, jika sesuai maka Admin akan melakukan Approve Purchased Topup
- Admin melakukan Approve Purchased Topup dengan eksekusi endpoint http://localhost:8080/transaction/:id [PUT], untuk mengubah status transaksi menjadi "success"

# Akun Login
- email Admin: admin@gmail.com / password: 12345
- email User1: user1@gmail.com / password: 12345
- email User2: user2@gmail.com / password: 12345

# 2. Feature user dapat login dan logout
- API Login ada di dalam folder User, endpoint http://localhost:8080/login [POST]

# 3. Feature user dapat topup balance.
- API Topup Balance ada di dalam folder TOPUP [Transaction], endpoint http://localhost:8080/transaction [POST]
- API Approve Purchased Topup ada di dalam folder TOPUP [transaction], endpoint http://localhost:8080/transaction/:id [PUT], endpoint ini hanya bisa diakses role Admin

# 4. Feature user dapat transfer balance.
- API Transfer Balance ada di dalam folder User Balance, endpoint http://localhost:8080/user-balance/transfer/:id [PATCH]

# 5. Di perbolehkan menambahkan kolom dan atau tabel tambahan jika diperlukan
- Penambahan tabel transaction, dan tambahan kolom pada tabel user

# 6. Pengerjaan pretest menggunakan repo github dan di beri akses publik.
- Repository ini dapat diakses di https://github.com/abeng123-ui/topup-project

# 9. Sertakan seed untuk schema database.
- Seed dapat diakses saat eksekusi rails db:seed

# 10. Sertakan nama framework dan cara menjalankan framework dalam readme
- Repo ini menggunakan framework Ruby On Rails, dan file readme terdapat pada file README.md
