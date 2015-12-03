require 'rails_helper'

def log_in(user)
  visit root_url
  click_link 'Login'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Log in'
end

context 'the favorite process' do
  it 'creates a new user favorite' do
    user = FactoryGirl.create(:user)
    visit root_url
    log_in user
    click_link("Ariel Pink", :match => :first)
    click_button('Add to Schedule', :match => :first)
    expect(page).to have_content "Delete Event"
  end

  it 'deletes a user favorite' do
    user = FactoryGirl.create(:user)
    visit root_url
    log_in user
    click_link("Ariel Pink", :match => :first)
    click_button('Add to Schedule', :match => :first)
    expect(page).to have_content "Festival Schedule"
    click_on "Delete Event"
    expect(page).to_not have_content "Ariel Pink"
  end

  it 'returns an error if event is already a user favorite' do
    user = FactoryGirl.create(:user)
    visit root_url
    log_in user
    click_link("Ariel Pink", :match => :first)
    click_button('Add to Schedule', :match => :first)
    expect(page).to have_content "Festival Schedule"
    visit root_url
    click_link("Ariel Pink", :match => :first)
    click_button('Add to Schedule', :match => :first)
    expect(page).to have_content "This event is already part of your schedule!"
  end
end

