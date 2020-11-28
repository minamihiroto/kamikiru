class Maching < ApplicationRecord
    # belongs_toでusersテーブルとの関係を記述(1対)
    # request_user,requested_userという架空のテーブルを参照しているが、実際はclass_name: 'User'でusersテーブルを参照していることになってる
    belongs_to :request_user, class_name: 'User'
    belongs_to :requested_user, class_name: 'User'
    # presence: trueで空データを登録できないようにする
    validates :request_user_id, presence: true
    validates :requested_user_id, presence: true
end
