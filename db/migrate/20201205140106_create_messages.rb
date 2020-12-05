class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :message_user, null: false,　foreign_key: { to_table: :users }, comment: "発言するユーザー"
      t.references :message_maching,　null: false, foreign_key: { to_table: :machings }, comment: "紐づいているマッチング"
      t.text :message_content,　null: false, comment: "メッセージの内容"
      t.timestamps
    end
  end
end
