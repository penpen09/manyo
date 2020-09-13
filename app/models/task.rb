class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { in: 1..100 }
  enum status: { 未着手: 0, 着手: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }

  scope :title_search, ->(title){ where("title LIKE ?", "%#{title}%") }
  scope :status_search, ->(status){ where(status: status) }
  scope :priority_search, ->(priority){ where(priority: priority) }
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings, source: :label
end
