class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many_attached :images

  # has_manyでmachingsテーブルとの関係を記述(多対）
  # foreign_keyでは、matchingsテーブルのrequest_user_idカラムによって紐付けが行われていることを明示しています
  has_many :machings, class_name: 'Maching', foreign_key: :request_user_id
  # :request_usersは架空のモデルでmachingsテーブルの:request_userを参考にしている
  # 中間テーブルをthorughで書くのは決り文句です
  # sourceは関連付けてるmodelを明示しています。今回はrequest_usersモデルなので、source: :request_userとQiitaにも書いてありました。
  # が、これは has_many :request_usersより明確なため、今回はなくても動くと思われます
  has_many :request_users, through: :machings
  # reverse_of_machingsは  has_many :machingsと名前を区別するために書いています。名前は何でもいいです。
  # foreign_keyでは、matchingsテーブルのrequested_user_idカラムによって紐付けが行われていることを明示しています
  has_many :reverse_of_machings, class_name: 'Maching', foreign_key: :requested_user_id
  # 中間テーブルをthorughで書くのは決り文句です
  has_many :requested_users, through: :reverse_of_machings

  def request(other_user)
    # selfはこの定義を呼び出したユーザーのこと
    # 自分にリクエスト送らないようにする記述
    unless self == other_user
      # other_user.idがmachingsのrequested_user_idカラムに存在するなら取得する、存在しないなら新規作成する(保存はしない)
      self.machings.find_or_initialize_by(request_user_id: self.id, requested_user_id: other_user.id)
    end
  end

  # 依頼取り消しの機能のため、コメントアウト
  # def unrequest(other_user)
  #   maching = self.machings.find_by(request_user_id: other_user.id)
  #   maching.destroy if maching
  # end



end
