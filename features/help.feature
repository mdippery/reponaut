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
          -c, --count         Sort by repo count
          -f, --ignore-forks  Ignore forked repos
          -h, --help          
          --version           
      """

  Scenario: List usage details with long option
    When I run `reponaut --help`
    Then it should pass with:
      """
      Usage: reponaut [OPTIONS] USERNAME

      Options:
          -c, --count         Sort by repo count
          -f, --ignore-forks  Ignore forked repos
          -h, --help          
          --version           
      """

  Scenario: Get version
    When I run `reponaut --version`
    Then the exit status should be 0
    And the stdout should contain:
      """
      reponaut, version
      """

  Scenario: Specify an invalid option
    When I run `reponaut -b`
    Then the exit status should not be 0
    And the stderr should contain:
      """
      unknown option `-b'
      Run `reponaut --help` for help information
      """

  Scenario: Specify no options
    When I run `reponaut`
    Then the exit status should not be 0
    And the stderr should contain:
      """
      Usage: reponaut [OPTIONS] USERNAME

      Options:
          -c, --count         Sort by repo count
          -f, --ignore-forks  Ignore forked repos
          -h, --help          
          --version           
      """
