Feature: List repos for a given language

  As a GitHub user
  I want to see what projects another user has created in a given language
  In order to see what software they've written

  Scenario: List repositories in a given language
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut ls mdippery VimL`
    Then it should pass with:
      """
      nginx.vim -> vim-scripts/nginx.vim
      Smyck-Color-Scheme -> hukl/Smyck-Color-Scheme
      vimfiles
      """

  Scenario: List repositories in a given language, ignoring case
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut ls mdippery viml`
    Then it should pass with:
      """
      nginx.vim -> vim-scripts/nginx.vim
      Smyck-Color-Scheme -> hukl/Smyck-Color-Scheme
      vimfiles
      """

  Scenario: List repositories in a given language, excluding forks
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut ls -f mdippery VimL`
    Then it should pass with:
      """
      vimfiles
      """

  Scenario: List repositories in a given language with no results
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut ls mdippery C++`
    Then the exit status should not be 0
    And the output should contain:
      """
      mdippery has no repositories written in C++
      """

  Scenario: List repositories for a given user when the API has been rate limited
    Given the GitHub service is rate limiting requests for the user "mdippery"
    When I run `reponaut ls mdippery python`
    Then the exit status should not be 0
    And stderr should contain:
      """
      GitHub rate limit exceeded. Try your request again later.
      """
