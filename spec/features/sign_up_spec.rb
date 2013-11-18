require 'spec_helper'

feature 'Sign up' do
  scenario 'allows a new user to sign up', :js do
    visit '/'

    click_link 'Sign up'
    within '#userModal' do
      fill_in 'user[name]', with: 'some'
      fill_in 'user[email]', with: 'some@test.com'
      fill_in 'user[password]', with: '123123123'
      fill_in 'user[password_confirmation]', with: '123123123'
      find('input[type=submit]').click
    end

    current_path.should == '/'
  end
end

