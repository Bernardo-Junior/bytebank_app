Feature: Verify Transaction Feed Screen
    Scenario: Test if transaction feed have one transaction effectived
    Given I have the dashboard screen with "scaffold_dashboard" scaffold
    When I tap on the "Transaction Feed" button
    Then I have the "transaction0" transaction exists
