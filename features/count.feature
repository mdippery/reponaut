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
    When I run `reponaut -s mdippery`
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
    When I run `reponaut --sort mdippery`
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
    When I run `reponaut -f -s mdippery`
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
