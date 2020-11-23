class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # 追記
  has_many_attached :images

  has_many :machings, class_name: 'Maching', foreign_key: :request_user_id
  has_many :request_users, through: :machings, source: :request_user

  has_many :reverse_of_machings, class_name: 'Maching', foreign_key: :requested_user_id
  has_many :requested_users, through: :reverse_of_machings, source: :requested_user

  def request(other_user)
    unless self == other_user
      self.machings.find_or_create_by(request_id: other_user.id)
    end
  end

  def unrequest(other_user)
    relationship = self.machings.find_by(request_id: other_user.id)
    relationship.destroy if relationship
  end

  def requesting?(other_user)
    self.requestings.include?(other_user)
  end

end
