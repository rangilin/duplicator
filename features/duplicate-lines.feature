Feature: Duplicate Lines
  In order to make copy and paste lines more efficiently
  As an Emacs user
  I want to duplicate lines with fewest key strokes


  Scenario: Duplicate current line when no region is active
    Given I insert:
    """
    The quick brown fox jumps over the lazy dog

    """
    And I place the cursor before "quick"
    When I press "C-c d"
    Then I should see:
    """
    The quick brown fox jumps over the lazy dog
    The quick brown fox jumps over the lazy dog

    """

  Scenario: Duplicate current line will preserve leading whitespace
    Given I insert:
    """
        The quick brown fox jumps over the lazy dog
    """
    When I press "C-c d"
    Then I should see:
    """
        The quick brown fox jumps over the lazy dog
        The quick brown fox jumps over the lazy dog
    """


  Scenario: Duplicate line will leave the cursor at the same column of the newer line
    Given I insert:
    """
    123456789

    """
    And I go to point "5"
    When I press "C-c d"
    Then I should see:
    """
    123456789
    123456789

    """
    And the cursor should be at point "15"


  Scenario: Duplicate lines in region if region is active
    Given I insert:
    """
    The quick brown fox
    jumps over the lazy dog
    """
    And I place the cursor after "quick"
    And I set the mark
    And I place the cursor after "over"
    When I press "C-c d"
    Then I should see:
    """
    The quick brown fox
    jumps over the lazy dog
    The quick brown fox
    jumps over the lazy dog
    """

  Scenario: After duplicate lines in region,  point will be placed at same column in newer lines
    Given I insert:
    """
    123456789
    000000000

    """
    And I go to point "5"
    And I set the mark
    And I go to point "15"
    When I press "C-c d"
    Then I should see:
    """
    123456789
    000000000
    123456789
    000000000

    """
    And the cursor should be at point "25"
