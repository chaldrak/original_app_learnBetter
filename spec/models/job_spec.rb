require 'rails_helper'

describe 'Job model function', type: :model do
  describe 'Validation test' do
    context 'If the job Title is empty' do
      it "It's hard to Validation" do
        user = User.new
        job = Job.new(title: '', content: 'Failure test', user: user)
        expect(job).not_to be_valid
      end
    end
    context 'If the job Content is empty' do
      it "It's hard to Validation" do
        user = User.new
        job = Job.new(title: 'Job test', content: '', user: user)
        expect(job).not_to be_valid
      end
    end
  end
end