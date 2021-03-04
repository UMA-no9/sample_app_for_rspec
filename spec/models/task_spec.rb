require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    let(:user){ FactoryBot.create(:user) }
    let(:task1) { FactoryBot.create(:task, user_id: user.id) }
    let(:task2) { FactoryBot.create(:task, user_id: user.id) }

    it 'is valid with all attributes' do
      task1.valid?
      expect(task1.errors.full_messages).to be_blank
    end

    it 'is invalid without title' do
      task1.title = ""
      task1.valid?
      expect(task1.errors.full_messages).to include "Title can't be blank"
    end

    it 'is invalid without status' do
      task1.status = nil
      task1.valid?
      expect(task1.errors.full_messages).to include "Status can't be blank"
    end

    it 'is invalid with a duplicate title' do
      task2.title = task1.title
      task2.valid?
      expect(task2.errors.full_messages).to include "Title has already been taken"
    end

    it 'is valid with another title' do
      task1
      task2.valid?
      expect(task2.errors.full_messages).to be_blank
    end
  end
end
