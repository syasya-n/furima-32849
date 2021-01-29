# README

## user テーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false              |
| email              | string | null: false,unique: true |
| encrypted_password | string | null: false              |
| last_name_kanji    | string | null: false              |
| first_name_kanji   | string | null: false              |
| last_name_kana     | string | null: false              |
| first_name_kana    | string | null: false              |
| birth_date         | date   | null: false              |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column                 | Type       | Options           |
| ---------------------- | ---------- | ----------------- |
| name                   | text       | null: false       |
| description            | text       | null: false       |
| category_id            | integer    | null: false       |
| condition_id           | integer    | null: false       |
| shipping_fee_person_id | integer    | null: false       |
| ship_from_region_id    | integer    | null: false       |
| delivery_day_id        | integer    | null: false       |
| price                  | integer    | null: false       |
| user                   | references | foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## orders テーブル

| Column | Type       | Options           |
| ------ | ---------- | ----------------- |
| user   | references | foreign_key: true |
| item   | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :delivery_location

## delivery_locations テーブル

| Column       | Type       | Options           |
| ------------ | ---------- | ----------------- |
| post_code    | string     | null: false       |
| region       | string     | null: false       |
| city         | string     | null: false       |
| address      | string     | null: false       |
| building     | string     |                   |
| phone_number | string     | null: false       |
| order        | references | foreign_key: true |

### Association

- belongs_to :order
