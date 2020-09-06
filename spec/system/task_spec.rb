require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_title", with: 'task'
        fill_in "task_content", with: 'task'
        select '完了', from: :task_status
        select '高', from: :task_priority
        select '2020', from: :task_limit_date_1i
        click_button "登録"
        expect(page).to have_content 'task'
        expect(page).to have_content '2020'
        expect(page).to have_content '完了'
        expect(page).to have_content '高'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task', content: 'content')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content 'タスク２'
      end
    end
    context 'タスクを終了期限でソートしたら昇順に並んでいる場合' do
      it '終了期限が近いタスクが一番上に表示される' do
        click_on '終了期限'
        task_list = all('.task_row_limit_date')
        expect(task_list[0]).to have_content '2020'
        expect(task_list[1]).to have_content '2021'
        expect(task_list[2]).to have_content '2022'
      end
    end
    context '優先順位でソートした場合' do
      it 'タスクが優先順位の降順に並んでいること' do
        visit tasks_path
        click_on '優先順位'
        task_list_p = all('.task_row_priority')
        expect(task_list_p[0]).to have_content '高'
        expect(task_list_p[2]).to have_content '低'
      end
    end
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in :title, with: 'タスク'
        click_button 'Search'
        expect(page).to have_content 'タスク'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '未着手', from: :status
        click_on 'Search'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in :title, with: 'タスク'
        select '着手', from: :status
        click_button 'Search'
        expect(page).to have_content '着手'
        expect(page).to have_content 'タスク'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:task, title: 'task')
         visit task_path(task.id)
         expect(page).to have_content 'task'
       end
     end
  end

end
