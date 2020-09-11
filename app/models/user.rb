class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy

  before_destroy :destroy_admin_user
  before_update :update_admin_user

  private
  def destroy_admin_user
    if User.where(admin: true).count == 1 && self.admin == true
      errors.add(:base, "少なくとも1名の管理者が必要")
      throw(:abort)
    end
  end
  def update_admin_user
    admin_user = User.where(admin: true)
    if (admin_user.count == 1 && admin_user.first == self) && !(self.admin?)
      errors.add(:base, "管理者が1名しかいないので管理者を外れることはできません")
      throw(:abort)
    end
  end
end
