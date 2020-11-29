class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many_attached :images

  # has_manyでmachingsテーブルとの関係を記述(多対）
  # foreign_keyでは、machingsテーブルのrequest_user_idカラムによって紐付けが行われていることを明示しています
  has_many :machings, class_name: 'Maching', foreign_key: :request_user_id
  # reverse_of_machingsはhas_many :machingsと名前を区別するために書いている
  # foreign_keyでは、machingsテーブルのrequested_user_idカラムによって紐付けが行われていることを明示している
  has_many :reverse_of_machings, class_name: 'Maching', foreign_key: :requested_user_id

  # 中間テーブルをthorughで書くのは決り文句です
  # request_usersで取得したいのはselfが依頼したユーザー、つまり「セルフに依頼されたユーザー」と言うことになる
  # その場合参照元は(source)はmachingsの依頼されたユーザーを表しているrequested_userになり、参照先がrequest_usersになる多対多の関係を記述
  has_many :request_users, through: :machings, source: :requested_user
  # 次は逆で、requested_usersで取得したいのはselfが依頼されたユーザー、つまり「セルフに依頼したユーザー」と言うことになる
  # その場合参照元は(source)はreverse_of_machingsの依頼したユーザーを表しているrequest_userになり、参照先がrequested_usersになる多対多の関係を記述
  has_many :requested_users, through: :reverse_of_machings, source: :request_user

  def request(other_user)
    # selfはこの定義を呼び出したユーザーのこと
    # 自分にリクエスト送らないようにする記述
    unless self == other_user
      # other_user.idがmachingsのrequested_user_idカラムに存在するなら取得する(もう存在するのでsaveができない状態)、存在しないなら新規作成する(保存はしないのでsaveができる状態)
      # 他のユーザーのidが依頼されたユーザーのidにあったらそのマッチングを取得し、なければマッチング登録すると言うこと
      self.machings.find_or_initialize_by(requested_user_id: other_user.id)
    end
  end

  # 依頼取り消しの機能のため、コメントアウト
  # def unrequest(other_user)
  #   maching = self.machings.find_by(request_user_id: other_user.id)
  #   maching.destroy if maching
  # end

  def requesting?(other_user)
    # self.request_usersメソッドで取得したいのは、「Selfに依頼されたユーザー」なので、扱われるModelはrequested_user
    # selfがother_userを依頼済みかどうかがわかる
    self.request_users.include?(other_user)
  end

  def requested?(other_user)
    # self.requested_usersメソッドで取得したいのは、「Selfに依頼したユーザー」なので、扱われるModelはrequest_user
    # selfがother_userに依頼されているかどうかがわかる
    self.requested_users.include?(other_user)
  end

end
