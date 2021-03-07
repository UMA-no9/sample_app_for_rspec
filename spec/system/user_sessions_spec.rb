require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user) }
  subject { page }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        login(user)
        is_expected.to have_selector('#notice', text: 'Login successful')
      end
    end
    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        visit login_path
        fill_in 'email', with: ''
        fill_in 'password', with: ''
        click_button 'Login'
        is_expected.to have_selector('#alert', text: 'Login failed')
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        login(user)
        visit root_path
        click_link 'Logout'
        expect(page).to have_content "Logged out"
      end
    end
  end
end
