# README
# DB 設計

## users table

|Column              |Type          |Options                   |
|--------------------|--------------|--------------------------|
|nickname            |string        |null: false               |
|email               |string        |null: false, unique: true |
|encrypted_password  |string        |null: false               |
|name                |string        |null: false               |
|birthday            |string        |null: false               |



### Association

* has_many :product
* has_many :purchase

## products table

|Column                    |Type          |Options                   |
|--------------------------|--------------|--------------------------|
|image                     |string        |null: false               |
|name                      |text          |null: false               |
|description               |text          |null: false               |
|categories                |string        |null: false               |
|Product condition         |string        |null: false               |
|Shipping costs            |string        |null: false               |


### Association
* belong_to :user
* has_one :purchase

## purchases table

|Column                    |Type          |Options                   |
|--------------------------|--------------|--------------------------|
|Producer                  |string        |null: false               |
|Categories                |string        |null: false               |
|Product condition         |string        |null: false               |
|Shipping costs            |string        |null: false               |
|Region of origin          |string        |null: false               |
|Estimated shipping date   |string        |null: false               |


### Association
* belong_to :product
* belong_to :user
* has_many :address

## addresses table

|Column                    |Type          |Options                   |
|--------------------------|--------------|--------------------------|
|post code                 |text          |null: false               |
|prefectures               |string        |null: false               |
|municipalities            |text          |null: false               |
|street address            |text          |null: false               |
|Building Name             |text          |null: false               |
|phone number              |text          |null: false               |

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

