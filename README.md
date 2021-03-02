#テーブル設計

##usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |


### Association

- has_many :items
- has_many :orders


##itemsテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| category_id         | integer    | null: false                    |
| condition_id        | integer    | null: false                    |
| delivery_fee_id     | integer    | null: false                    |
| prefectures_id      | integer    | null: false                    |
| days_to_ship_id     | integer    | null: false                    |
| price               | integer    | null: false                    |
| description         | text       | null: false
| user                | references | null: false, foreign_key: true | 

### Association

- belongs_to :user
- belongs_to :order

##ordersテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :destination

##destinationsテーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| postal_code      | string     | null: false                    |
| prefectures_id   | integer    | null: false                    | 
| municipality     | string     | null: false                    |
| address          | string     | null: false                    |
| building         | string     |                                |
| phone number     | string     | null: false                    |
| orders           | references | null: false, foreign_key: true |

### Association

- belongs_to :order


