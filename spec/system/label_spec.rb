require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  before do
    FactoryBot.create(:label)
    FactoryBot.create(:second_label)
    visit new_session_path
    fill_in "Email address", with: 'admin@admin.com'
    fill_in "Password", with: 'password'
    click_on 'Log in'
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it 'タスクと一緒にラベルを付けられる' do
        visit new_task_path
        fill_in :task_title, with: 'task'
        fill_in :task_content, with: 'task'
        select '完了', from: :task_status
        select '高', from: :task_priority
        select '2020', from: :task_limit_date_1i
        check 'Label_1'
        click_button "登録"
        expect(page).to have_content 'Label_1'
      end
      it 'タスクと一緒にラベルを複数付けられる' do
        visit new_task_path
        fill_in :task_title, with: 'task'
        fill_in :task_content, with: 'task'
        select '完了', from: :task_status
        select '高', from: :task_priority
        select '2020', from: :task_limit_date_1i
        check 'Label_1'
        check 'Label_2'
        click_button "登録"
        expect(page).to have_content 'Label_1'
        expect(page).to have_content 'Label_2'
      end
    end
  end

  describe '編集機能' do
    before do
      visit new_task_path
      fill_in :task_title, with: 'task'
      fill_in :task_content, with: 'task'
      select '完了', from: :task_status
      select '高', from: :task_priority
      select '2020', from: :task_limit_date_1i
      check 'Label_1'
      click_button "登録"
      visit tasks_path
    end
    context 'タスクを編集した場合' do
      it 'タスクと一緒にラベルを編集できる' do
        click_on '編集'
        check 'Label_2'
        click_button "更新する"
        expect(page).to have_content 'Label_1'
        expect(page).to have_content 'Label_2'
      end
      it 'ラベルを削除できる' do
        visit tasks_path
        click_on '編集'
        uncheck 'Label_1'
        uncheck 'Label_2'
        click_button "更新する"
        task_list = all('.task_row_label')
        expect(task_list[0]).not_to have_content 'Label_1'
        expect(task_list[0]).not_to have_content 'Label_2'
      end
    end
  end

  describe '検索機能' do
    context 'ラベル検索をした場合' do
      it "一致するラベルが絞り込まれる" do
        visit new_task_path
        fill_in :task_title, with: 'task'
        fill_in :task_content, with: 'task'
        select '完了', from: :task_status
        select '高', from: :task_priority
        select '2020', from: :task_limit_date_1i
        check 'Label_1'
        click_button "登録"
        visit tasks_path
        select 'Label_1', from: :label_id
        click_button 'Search'
        task_list = all('.task_row_label')
        expect(task_list[0]).to have_content 'Label_1'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容とラベルが表示される' do
         task = FactoryBot.create(:task, user: user)
         visit edit_task_path(task.id)
         check 'Label_1'
         click_button "更新する"
         visit task_path(task.id)
         expect(page).to have_content 'Label_1'
       end
     end
  end

end
