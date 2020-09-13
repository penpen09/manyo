require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'タスクモデル機能', type: :model do
    describe 'バリデーションのテスト' do
      context 'タスクのタイトルが空の場合' do
        it 'バリデーションにひっかる' do
          task = Task.new(title: '', content: '失敗テスト')
          expect(task).not_to be_valid
        end
      end
      context 'タスクの詳細が空の場合' do
        it 'バリデーションにひっかかる' do
          task = Task.new(title: '失敗テスト', content: '')
          expect(task).not_to be_valid
        end
      end
      context 'タスクのタイトルと詳細に内容が記載されている場合' do
        it 'バリデーションが通る' do
          user = FactoryBot.create(:user)
          task = Task.new(title: '成功テスト', content: '成功テスト', limit_date: DateTime.now, user_id: user.id)
          expect(task).to be_valid
        end
      end
    end

    describe '検索機能' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:task) {FactoryBot.create(:task, title: 'task', content: "rails", status: "完了", user: user)}
      let!(:task2) {FactoryBot.create(:task, title: 'today', content: "javascript", status: "着手", user: user)}
      context 'scopeメソッドでタイトルのあいまい検索をした場合' do
        it "検索キーワードを含むタスクが絞り込まれる" do
          # title_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
          expect(Task.title_search('task')).to include(task)
          expect(Task.title_search('task')).not_to include(task2)
          expect(Task.title_search('task').count).to eq 1
        end
      end
      context 'scopeメソッドでステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          expect(Task.status_search('完了').count).to eq 1
        end
      end
      context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          expect(Task.title_search('task').status_search('完了').count).to eq 1
        end
      end
    end
  end
end
