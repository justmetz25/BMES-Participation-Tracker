require 'rails_helper'

RSpec.describe 'Login page', type: :system do
    describe 'Login' do
        it 'Success' do
            visit new_admin_user_session_path
            fill_in('admin_user[email]', :with => 'admin@example.com')
            fill_in('admin_user[password]', :with => 'password')
            #sleep(2)
            click_button('Login')
            expect(page).to have_content('Signed in successfully.')
            #sleep(2)
        end
        it 'Fail' do
            visit new_admin_user_session_path
            fill_in('admin_user[email]', :with => 'admin@example.com')
            fill_in('admin_user[password]', :with => 'p')
            #sleep(2)
            click_button('Login')
            expect(page).to have_content('Invalid Email or password.')
            #sleep(2)
        end
    end
end

RSpec.describe 'Event page', type: :system do
    describe 'Visit Events' do
        it 'Homepage' do
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
            
            #sleep(2)
        end
        it 'Specific event' do
            visit events_path
            #sleep(2)
            click_link('Show')
            expect(page).to have_selector(:link_or_button, '<< Back to List')

            expect(page).to have_content('Show event')
            
            expect(page).to have_content('Title')
            expect(page).to have_content('Place')
            expect(page).to have_content('Description')
            expect(page).to have_content('Attendees')
            #sleep(2)
        end
        it 'Go back to home' do
            visit events_path
            #sleep(2)
            click_link('Show')
            #sleep(2)
            click_link('<< Back to List')
            #sleep(2)
        end
    end
    describe 'View attendances' do
        it 'Submit from Participation page' do
            visit events_path
            click_link('Sign in to event')
    
            fill_in('event_id', :with => '1')
            fill_in('event_pass', :with => '1')
            fill_in('participation[uin]', :with => '666666666')
            fill_in('participation[first_name]', :with => 'John')
            fill_in('participation[last_name]', :with => 'Doe')
            fill_in('participation[email]', :with => 'jdoe@example.com')
            #sleep(2)
    
            click_button('commit')
            visit events_path
            click_link('Show')
            expect(page).to have_content('666666666')
            expect(page).to have_content('John')
            expect(page).to have_content('Doe')
            expect(page).to have_content('jdoe@example.com')
            #sleep(2)
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
            #sleep(2)

            click_button('commit')
            expect(page).to have_content('Successfully signed in')
            #sleep(2)
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
            #sleep(2)

            click_button('commit')
            expect(page).to have_content('Incorrect password')
            #sleep(2)
        end
    end
    describe 'Input Validation Fail' do
        it 'Password' do
            visit events_path
            click_link('Sign in to event')

            fill_in('event_id', :with => '1')
            click_button('commit')
            
            message = page.find('#event_pass').native.attribute('validationMessage')
            expect(message).to eq 'Please fill out this field.'
            #sleep(2)
        end
        it 'UIN' do
            visit events_path
            click_link('Sign in to event')

            fill_in('event_id', :with => '1')
            fill_in('event_pass', :with => '1')
            click_button('commit')

            message = page.find('#participation_uin').native.attribute('validationMessage')
            expect(message).to eq 'Please fill out this field.'
            #sleep(2)
        end
        it 'First Name' do
            visit events_path
            click_link('Sign in to event')

            fill_in('event_id', :with => '1')
            fill_in('event_pass', :with => '1')
            fill_in('participation[uin]', :with => '999999999')
            click_button('commit')

            message = page.find('#participation_first_name').native.attribute('validationMessage')
            expect(message).to eq 'Please fill out this field.'
            #sleep(2)
        end
        it 'Last Name' do
            visit events_path
            click_link('Sign in to event')

            fill_in('event_id', :with => '1')
            fill_in('event_pass', :with => '1')
            fill_in('participation[uin]', :with => '999999999')
            fill_in('participation[first_name]', :with => 'Bob')
            click_button('commit')

            message = page.find('#participation_last_name').native.attribute('validationMessage')
            expect(message).to eq 'Please fill out this field.'
            #sleep(2)
        end
        it 'Email' do
            visit events_path
            click_link('Sign in to event')

            fill_in('event_id', :with => '1')
            fill_in('event_pass', :with => '1')
            fill_in('participation[uin]', :with => '999999999')
            fill_in('participation[first_name]', :with => 'Bob')
            fill_in('participation[last_name]', :with => 'Ross')
            click_button('commit')

            message = page.find('#participation_email').native.attribute('validationMessage')
            expect(message).to eq 'Please fill out this field.'
            #sleep(2)
        end
    end
end
#Above is alex

RSpec.describe 'Admin Create Event', type: :system do
    describe 'Create Event' do
        before do
            visit new_admin_user_session_path
            fill_in('admin_user[email]', :with => 'admin@example.com')
            fill_in('admin_user[password]', :with => 'password')
            #sleep(2)
            click_button('Login')
            click_on 'Events'
            click_on 'New Event'
            end

        it 'Success Create Event' do
            fill_in 'Title', with: "title1"
            fill_in 'Place', with: 'place1'
            fill_in 'Description', with: 'des1'
            
            #sleep(4)
            select "2015", :from => "event[starttime(1i)]"
            select "November", :from => "event[starttime(2i)]"
            select "2", :from => "event[starttime(3i)]"
            select "10", :from => "event[starttime(4i)]"
            select "00", :from => "event[starttime(5i)]"

            select "2015", :from => "event[endtime(1i)]"
            select "November", :from => "event[endtime(2i)]"
            select "2", :from => "event[endtime(3i)]"
            select "12", :from => "event[endtime(4i)]"
            select "00", :from => "event[endtime(5i)]"

            fill_in 'Eventpass', with: '1128'

            click_on 'Create Event'
            sleep(2)
            expect(page).to have_content('Event was successfully created.')
            #sleep(2)
        end

        

        it 'Success Edit Event' do
            fill_in 'Title', with: "title1"
            fill_in 'Place', with: 'place1'
            fill_in 'Description', with: 'des1'
            
            #sleep(4)
            select "2015", :from => "event[starttime(1i)]"
            select "November", :from => "event[starttime(2i)]"
            select "2", :from => "event[starttime(3i)]"
            select "10", :from => "event[starttime(4i)]"
            select "00", :from => "event[starttime(5i)]"

            select "2015", :from => "event[endtime(1i)]"
            select "November", :from => "event[endtime(2i)]"
            select "2", :from => "event[endtime(3i)]"
            select "12", :from => "event[endtime(4i)]"
            select "00", :from => "event[endtime(5i)]"
            fill_in 'Eventpass', with: '1128'
            click_on 'Create Event'

            #edit
            click_on 'Edit Event'
            fill_in 'Title', with: "title1"
            fill_in 'Place', with: 'place1'
            fill_in 'Description', with: 'des1'
            
            #sleep(4)
            select "2016", :from => "event[starttime(1i)]"
            select "November", :from => "event[starttime(2i)]"
            select "2", :from => "event[starttime(3i)]"
            select "10", :from => "event[starttime(4i)]"
            select "00", :from => "event[starttime(5i)]"

            select "2016", :from => "event[endtime(1i)]"
            select "November", :from => "event[endtime(2i)]"
            select "2", :from => "event[endtime(3i)]"
            select "12", :from => "event[endtime(4i)]"
            select "00", :from => "event[endtime(5i)]"

            fill_in 'Eventpass', with: '11128'

            click_on 'Update Event'

            sleep(2)
            expect(page).to have_content('Event was successfully updated.')
            #sleep(2)
        end

        it 'Success Delete Event' do
            fill_in 'Title', with: "title1"
            fill_in 'Place', with: 'place1'
            fill_in 'Description', with: 'des1'
            
            #sleep(4)
            select "2015", :from => "event[starttime(1i)]"
            select "November", :from => "event[starttime(2i)]"
            select "2", :from => "event[starttime(3i)]"
            select "10", :from => "event[starttime(4i)]"
            select "00", :from => "event[starttime(5i)]"

            select "2015", :from => "event[endtime(1i)]"
            select "November", :from => "event[endtime(2i)]"
            select "2", :from => "event[endtime(3i)]"
            select "12", :from => "event[endtime(4i)]"
            select "00", :from => "event[endtime(5i)]"

            fill_in 'Eventpass', with: '1128'

            click_on 'Create Event'
            click_on 'Delete Event'
            page.driver.browser.switch_to.alert.accept
            sleep(2)
            expect(page).to have_content('Event was successfully destroyed.')
            #sleep(2)
        end

        it 'Success Add Comments' do
            fill_in 'Title', with: "title1"
            fill_in 'Place', with: 'place1'
            fill_in 'Description', with: 'des1'
            
            #sleep(4)
            select "2015", :from => "event[starttime(1i)]"
            select "November", :from => "event[starttime(2i)]"
            select "2", :from => "event[starttime(3i)]"
            select "10", :from => "event[starttime(4i)]"
            select "00", :from => "event[starttime(5i)]"

            select "2015", :from => "event[endtime(1i)]"
            select "November", :from => "event[endtime(2i)]"
            select "2", :from => "event[endtime(3i)]"
            select "12", :from => "event[endtime(4i)]"
            select "00", :from => "event[endtime(5i)]"

            fill_in 'Eventpass', with: '1128'

            click_on 'Create Event'
            fill_in 'active_admin_comment[body]', with: "comment1"
            click_on 'Add Comment'
            sleep(2)
            expect(page).to have_content('Comment was successfully created.')
            #sleep(2)
        end

        it 'Success Delete Comments' do
            fill_in 'Title', with: "title1"
            fill_in 'Place', with: 'place1'
            fill_in 'Description', with: 'des1'
            
            #sleep(4)
            select "2015", :from => "event[starttime(1i)]"
            select "November", :from => "event[starttime(2i)]"
            select "2", :from => "event[starttime(3i)]"
            select "10", :from => "event[starttime(4i)]"
            select "00", :from => "event[starttime(5i)]"

            select "2015", :from => "event[endtime(1i)]"
            select "November", :from => "event[endtime(2i)]"
            select "2", :from => "event[endtime(3i)]"
            select "12", :from => "event[endtime(4i)]"
            select "00", :from => "event[endtime(5i)]"

            fill_in 'Eventpass', with: '1128'

            click_on 'Create Event'
            fill_in 'active_admin_comment[body]', with: "comment1"
            click_on 'Add Comment'
            click_on 'Delete Comment'
            page.driver.browser.switch_to.alert.accept
            sleep(2)
            expect(page).to have_content('Comment was successfully destroyed.')
            #sleep(2)
        end
        # it 'Fails with same event time' do
        #     #make a event
        #     fill_in 'Title', with: "title1"
        #     fill_in 'Place', with: 'place1'
        #     fill_in 'Description', with: 'des1'
            
        #     #sleep(4)
        #     select "2015", :from => "event[starttime(1i)]"
        #     select "November", :from => "event[starttime(2i)]"
        #     select "2", :from => "event[starttime(3i)]"
        #     select "10", :from => "event[starttime(4i)]"
        #     select "00", :from => "event[starttime(5i)]"

        #     select "2015", :from => "event[endtime(1i)]"
        #     select "November", :from => "event[endtime(2i)]"
        #     select "2", :from => "event[endtime(3i)]"
        #     select "12", :from => "event[endtime(4i)]"
        #     select "00", :from => "event[endtime(5i)]"

        #     fill_in 'Eventpass', with: '1128'

        #     click_on 'Create Event'

        #     #start another event
        #     click_on 'Dashboard'
        #     click_on 'Events'
        #     click_on 'New Event'
        #     fill_in 'Title', with: "title2"
        #     fill_in 'Place', with: 'place2'
        #     fill_in 'Description', with: 'des2'
            
        #     #sleep(4)
        #     select "2015", :from => "event[starttime(1i)]"
        #     select "November", :from => "event[starttime(2i)]"
        #     select "2", :from => "event[starttime(3i)]"
        #     select "10", :from => "event[starttime(4i)]"
        #     select "00", :from => "event[starttime(5i)]"

        #     select "2015", :from => "event[endtime(1i)]"
        #     select "November", :from => "event[endtime(2i)]"
        #     select "2", :from => "event[endtime(3i)]"
        #     select "12", :from => "event[endtime(4i)]"
        #     select "00", :from => "event[endtime(5i)]"

        #     fill_in 'Eventpass', with: '113897'
        #     click_on 'Create Event'
        #     click_on 'Dashboard'
        #     click_on 'Events'
        #     #click_on 'Events'
            
        #     sleep(5)
        #     expect(page).to have_content('1128')
        #     #sleep(2)
        # end
    end
end