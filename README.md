# README
# DB 設計

## users table

|Column              |Type          |Options                   |
|--------------------|--------------|--------------------------|
|nickname            |string        |null: false               |
|email               |string        |null: false, unique: true |
|encrypted_password  |string        |null: false               |
|first_name          |string        |null: false               |
|last_name           |string        |null: false               |
|first_name_kana     |string        |null: false               |
|last_name_kana      |string        |null: false               |
|date                |string        |null: false               |



### Association

* has_many :products
* has_many :purchases

## products table

|Column                            |Type          |Options                   |
|----------------------------------|--------------|--------------------------|
|name                              |string        |null: false               |
|description                       |text          |null: false               |
|category_id                       |integer       |null: false               |
|product_condition_id              |integer       |null: false               |
|shipping_cost_id                  |integer       |null: false               |
|region of origin_id               |integer       |null: false               |
|estimated_shipping_date_id        |integer       |null: false               |
|price                             |text          |null: false               |




### Association
* belong_to :user
* has_one :purchase

## purchases table

|Column                           |Type          |Options                   |
|---------------------------------|--------------|--------------------------|
|user_id                          |string        |null: false               |
|product_id                       |string        |null: false               |


### Association
* belong_to :product
* belong_to :user
* has_one :address

## addresses table

|Column                    |Type            |Options                   |
|--------------------------|----------------|--------------------------|
|purchase_id               |string          |null: false               |
|post_code                 |string          |null: false               |
|prefectures_id            |integer         |null: false               |
|municipalities            |string          |null: false               |
|street_address            |string          |null: false               |
|building_name             |string          |                          |
|phone_number              |string          |null: false               |

### Association
* belong_to :product
* belong_to :user
* belong_to :address




















This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

