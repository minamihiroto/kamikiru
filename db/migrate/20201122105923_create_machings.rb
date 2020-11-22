class CreateMachings < ActiveRecord::Migration[6.0]
  def change
    create_table :machings, comment: 'マッチングテーブル' do |t|
      t.references :request_user, foreign_key: { to_table: :users }, comment: "リクエストしたユーザー"
      t.references :requested_user, foreign_key: { to_table: :users }, comment: "リクエストされたユーザー"
      t.boolean :aggree, default: false, comment: "承諾可否"
      t.timestamps
      t.index [:request_user_id, :requested_user_id], unique: true
    end
  end
end
