class CreateMachings < ActiveRecord::Migration[6.0]
  def change
    create_table :machings, comment: 'マッチングテーブル' do |t|
      # referencesでindexも作成できる
      # foreign_key: { to_table: :users }でusersテーブルに紐付けする
      t.references :request_user, foreign_key: { to_table: :users }, comment: "リクエストしたユーザー"
      t.references :requested_user, foreign_key: { to_table: :users }, comment: "リクエストされたユーザー"
      t.boolean :aggree, default: false, comment: "承諾可否"
      t.timestamps
      # request_user_id と requested_user_id のペアで重複するものが保存されないようにするデータベースの設定（ユニークインデックス）
      t.index [:request_user_id, :requested_user_id], unique: true
    end
  end
end
