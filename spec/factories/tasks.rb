# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    limit_date { '2020-09-02 12:00:00'}
    status { '完了' }
    priority { '高' }
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'タスク' }
    content { 'コンテント' }
    limit_date { '2021-09-12 12:00:00'}
    status { '着手' }
    priority { '中' }
  end
  factory :third_task, class: Task do
    title { 'タスク２' }
    content { 'コンテント２' }
    limit_date { '2022-09-22 12:00:00'}
    status { '未着手' }
    priority { '低' }
  end
end
