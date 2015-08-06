Feature: Get help

  As a GitHub user
  I want to be able to list help information for reponaut
  In order to learn how to use it

  Scenario: List usage details
    When I run `reponaut -h`
    Then it should pass with:
      """
      Usage: reponaut [OPTIONS] USERNAME

      Options:
        --version           Show the version and exit.
        -s, --sort          Sort by repo count.
        -f, --ignore-forks  Ignore forked repos.
        -h, --help          Show this message and exit.
      """

  Scenario: List usage details with long option
    When I run `reponaut --help`
    Then it should pass with:
      """
      Usage: reponaut [OPTIONS] USERNAME

      Options:
        --version           Show the version and exit.
        -s, --sort          Sort by repo count.
        -f, --ignore-forks  Ignore forked repos.
        -h, --help          Show this message and exit.
      """

  Scenario: Get version
    When I run `reponaut --version`
    Then the exit status should be 0
    And the stdout should contain:
      """
      reponaut, version
      """
