class Menu < ApplicationRecord
  MAX_POSTS_COUNT = 3
  belongs_to :user

  validate :user_has_limit_menus

  def self.search(keyword)
    if keyword
      where(['name LIKE ?', "%#{keyword}%"])
    else
      Menu.all
    end
  end

  private
  def user_has_limit_menus
    if user.menus.count >= MAX_POSTS_COUNT
      puts "aaa"
      errors.add(:base, "メニュー登録数は最大#{MAX_POSTS_COUNT}つまでです")
    end
  end
end
