# Feature: Verify Contacts Screen
#     Scenario: Test create contact and verify if exists on contacts screen
#     Given I have the dashboard screen with "scaffold_dashboard" scaffold
#     When I tap on the "Contacts" button
#     Then I tap on the "floating_create_contact" floating action button
#     Given I have "name_input" and "account_input"
#     When I fill the "name_input" field with "Bernardo Junior"
#     And I fill the "account_input" field with "1234"
#     Then I tap the "send_button" button
#     And I have the "contact0" contact exists