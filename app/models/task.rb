class Task < ApplicationRecord
  validates :title, presence: true
  validates :conent, presence: true, length: { in: 1..100 }
end
