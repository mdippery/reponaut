Feature: Get help

  As a GitHub user
  I want to be able to list help information for reponaut
  In order to learn how to use it

  Scenario: List usage details
    When I run `reponaut -h`
    Then it should pass with:
      """
      Usage:

        reponaut <command> [options] <args>

      Options:
              -h, --help         Show this message
              -v, --version      Print the name and version
              -t, --trace        Show the full backtrace when an error occurs

      Subcommands:
        count                 Shows a breakdown of a user's total number of repos
        list, ls              List a user's repos
      """

  Scenario: List usage details with long option
    When I run `reponaut --help`
    Then it should pass with:
      """
      Usage:

        reponaut <command> [options] <args>

      Options:
              -h, --help         Show this message
              -v, --version      Print the name and version
              -t, --trace        Show the full backtrace when an error occurs

      Subcommands:
        count                 Shows a breakdown of a user's total number of repos
        list, ls              List a user's repos
      """

  Scenario: Get version
    When I run `reponaut --version`
    Then the exit status should be 0
    And the output should match:
      """
      reponaut [0-9]+\.[0-9]+\.[0-9]+(\.[a-z]+)?
      """

  Scenario: Specify an invalid option
    When I run `reponaut -b`
    Then the exit status should not be 0
    And the stderr should contain:
      """
      Whoops, we can't understand your command.
      invalid option: -b
      Run your command again with the --help switch to see available options.
      """

  Scenario: Specify no options
    When I run `reponaut`
    Then it should pass with:
      """
      Usage:

        reponaut <command> [options] <args>

      Options:
              -h, --help         Show this message
              -v, --version      Print the name and version
              -t, --trace        Show the full backtrace when an error occurs

      Subcommands:
        count                 Shows a breakdown of a user's total number of repos
        list, ls              List a user's repos
      """
