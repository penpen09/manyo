class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { in: 1..100 }
  validates :limit_date, presence: true
  enum status: { 未着手: 0, 着手: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }

  scope :title_search, ->(title){ where("title LIKE ?", "%#{title}%") }
  scope :status_search, ->(status){ where(status: status) }
  scope :priority_search, ->(priority){ where(priority: priority) }
end
