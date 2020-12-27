class CreateMenus < ActiveRecord::Migration[6.0]
  def change
    create_table :menus do |t|
      t.references :user, null: false,　foreign_key: true, comment: "（やって欲しいorできる）menuを設定するユーザー"
      t.string :name, comment: "メニュー名"
      t.integer :fee, comment: "料金"
      t.timestamps
    end
  end
end
