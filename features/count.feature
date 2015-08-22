Feature: Count repositories by language

  As a GitHub user
  I want to quickly list another user's repositories
  In order to see what languages they use to write code

  Scenario: List repository counts sorted by language
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut mdippery`
    Then it should pass with:
      """
      C               1
      Clojure         3
      Erlang          1
      Java            2
      JavaScript      1
      Objective-C     5
      Perl            1
      Python          4
      Ruby            3
      VimL            3
      """

  Scenario: List repository counts sorted by language count
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut -c mdippery`
    Then it should pass with:
      """
      Objective-C     5
      Python          4
      Clojure         3
      Ruby            3
      VimL            3
      Java            2
      C               1
      Erlang          1
      JavaScript      1
      Perl            1
      """

  Scenario: List repository counts sorted by language count using long option
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut --count mdippery`
    Then it should pass with:
      """
      Objective-C     5
      Python          4
      Clojure         3
      Ruby            3
      VimL            3
      Java            2
      C               1
      Erlang          1
      JavaScript      1
      Perl            1
      """

  Scenario: List repository counts for source repositories ordered by language
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut -f mdippery`
    Then it should pass with:
      """
      C               1
      Clojure         3
      Erlang          1
      Java            2
      JavaScript      1
      Objective-C     5
      Perl            1
      Python          2
      Ruby            3
      VimL            1
      """

  Scenario: List repository counts for source repositories ordered by language using long option
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut --ignore-forks mdippery`
    Then it should pass with:
      """
      C               1
      Clojure         3
      Erlang          1
      Java            2
      JavaScript      1
      Objective-C     5
      Perl            1
      Python          2
      Ruby            3
      VimL            1
      """

  Scenario: List repository counts for source repositories ordered by count
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut -f -c mdippery`
    Then it should pass with:
      """
      Objective-C     5
      Clojure         3
      Ruby            3
      Java            2
      Python          2
      C               1
      Erlang          1
      JavaScript      1
      Perl            1
      VimL            1
      """

    Scenario: List repository counts for users with over 10 repositories
      Given the GitHub service returns repository data for the user "testuser1"
      When I run `reponaut testuser1`
      Then it should pass with:
        """
        HTML             1
        Objective-C      8
        Python           1
        Ruby             1
        Shell            1
        Swift           12
        """

  Scenario: List repository counts for a non-existent user
    Given the GitHub service returns 404 for the user "nosuchuser"
    When I run `reponaut nosuchuser`
    Then the exit status should not be 0
    And the stderr should contain:
      """
      No such user: nosuchuser
      """

  Scenario: List repository counts for a user with no repositories
    Given the GitHub service returns repository data for the user "emptyuser"
    When I run `reponaut emptyuser`
    Then the exit status should not be 0
    And the stderr should contain:
      """
      emptyuser has no repositories
      """
