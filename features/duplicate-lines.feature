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
    And
