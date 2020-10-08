require 'rails_helper'

RSpec.describe 'Login page', type: :system do
    describe 'Login' do
        it 'Success' do
            visit new_admin_user_session_path
            fill_in('admin_user[email]', :with => 'admin@example.com')
            fill_in('admin_user[password]', :with => 'password')
            sleep(2)
            click_button('Login')
            expect(page).to have_content('Signed in successfully.')
            sleep(2)
        end
        it 'Fail' do
            visit new_admin_user_session_path
            fill_in('admin_user[email]', :with => 'admin@example.com')
            fill_in('admin_user[password]', :with => 'p')
            sleep(2)
            click_button('Login')
            expect(page).to have_content('Invalid Email or password.')
            sleep(2)
        end
    end
end

RSpec.describe 'Event page', type: :system do
    describe 'Visit Events' do
        it 'Visit event homepage' do
            visit events_path

            expect(page).to have_selector(:link_or_button, 'Show')
            expect(page).to have_selector(:link_or_button, 'Sign in to event')

            expect(page).to have_content('Events')
            expect(page).to have_content('ID')
            expect(page).to have_content('Title')
            expect(page).to have_content('Place')
            expect(page).to have_content('Description')
            expect(page).to have_content('Start Time')
            expect(page).to have_content('End Time')
            
            sleep(2)
        end
        it 'View specific event' do
            visit events_path
            sleep(2)
            click_link('Show')
            expect(page).to have_selector(:link_or_button, '<< Back to List')

            expect(page).to have_content('Show event')
            
            expect(page).to have_content('Title')
            expect(page).to have_content('Place')
            expect(page).to have_content('Description')
            expect(page).to have_content('Attendees')
            sleep(2)
        end
        it 'Go back to home' do
            visit events_path
            sleep(2)
            click_link('Show')
            sleep(2)
            click_link('<< Back to List')
            sleep(2)
        end
    end
end

RSpec.describe 'Participation Page', type: :system do
    describe 'Submit attendance' do
        it 'Visit page' do
            visit events_path
            click_link('Sign in to event')

            expect(page).to have_content('Password')
            expect(page).to have_content('UIN')
            expect(page).to have_content('First Name')
            expect(page).to have_content('Last Name')
            expect(page).to have_content('Email')
            expect(page).to have_selector(:link_or_button, 'Sign In')
        end
        it 'Successful Submit' do
            visit events_path
            click_link('Sign in to event')

            fill_in('event_id', :with => '1')
            fill_in('event_pass', :with => '1')
            fill_in('participation[uin]', :with => '666666666')
            fill_in('participation[first_name]', :with => 'John')
            fill_in('participation[last_name]', :with => 'Doe')
            fill_in('participation[email]', :with => 'jdoe@example.com')
            sleep(2)

            click_button('commit')
            expect(page).to have_content('Successfully signed in')
            sleep(2)
        end
        it 'Failed Submit via Password' do
            visit events_path
            click_link('Sign in to event')

            fill_in('event_id', :with => '1')
            fill_in('event_pass', :with => '2')
            fill_in('participation[uin]', :with => '666666666')
            fill_in('participation[first_name]', :with => 'John')
            fill_in('participation[last_name]', :with => 'Doe')
            fill_in('participation[email]', :with => 'jdoe@example.com')
            sleep(2)

            click_button('commit')
            expect(page).to have_content('Incorrect password')
            sleep(2)
        end
        # Need to figure out how to trigger failed validation and see the state
        # it 'Password Input Validation Failed' do
        #     visit events_path
        #     click_link('Sign in to event')

        #     fill_in('event_id', :with => '1')
        #     click_button('commit')
            
        #     message = page.find('event_pass').native.attribute("validationMessage")
        #     expect(message).to eq "Please fill out this field."
        # end
    end
end