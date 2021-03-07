require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:user) { create(:user) }
  let(:task) { create(:task, user_id: user.id) }
  let(:other_task) { create(:task, title: 'other_task_title') }
  subject { page }

  describe 'ログイン前' do
    it 'タスクの新規作成ができない' do
      visit new_task_path
      is_expected.to have_selector('#alert', text: 'Login required')
    end

    it 'タスクの編集ができない' do
      visit edit_task_path(task)
      is_expected.to have_selector('#alert', text: 'Login required')
    end
  end

  describe 'ログイン後' do
    before { login(user) }

    describe 'タスクの作成' do
      context 'フォームの入力値が正常' do
        it 'タスクの新規作成ができる' do
          visit new_task_path
          fill_in 'Title', with: 'task_title'
          click_button 'Create Task'
          is_expected.to have_content 'Task was successfully created.'
        end
      end

      context 'タイトルが未入力' do
        it 'タスクの新規作成ができない' do
          visit new_task_path
          fill_in 'Title', with: ''
          click_button 'Create Task'
          is_expected.to have_content "Title can't be blank"
          is_expected.to have_content "Title can't be blank"
        end
      end

      context 'タイトルが重複' do
        it 'タスクの新規作成ができない' do
          visit new_task_path
          fill_in 'Title', with: other_task.title
          click_button 'Create Task'
          is_expected.to have_selector('#error_explanation', text: 'Title has already been taken')
          is_expected.to have_no_content(other_task.title)
        end
      end
    end

    describe 'タスクの編集' do
      context '有効なタイトル' do
        it 'タスクの編集ができる' do
          visit edit_task_path(task)
          fill_in 'Title', with: 'edited_title'
          click_button 'Update Task'
          is_expected.to have_selector('#notice', text: 'Task was successfully updated')
        end
      end

      context 'タイトルが未入力' do
        it 'タスクの編集ができない' do
          visit edit_task_path(task)
          fill_in 'Title', with: ''
          click_button 'Update Task'
          is_expected.to have_selector('#error_explanation', text: "Title can't be blank")
        end
      end
    end

    describe 'タスクの削除' do
      it 'タスクの削除ができる' do
        task
        visit tasks_path
        page.accept_confirm { click_link 'Destroy' }
        is_expected.to have_selector('#notice', text: 'Task was successfully destroyed') end
    end
  end
end
