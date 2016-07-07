Feature: List repos for a given language

  As a GitHub user
  I want to see what projects another user has created in a given language
  In order to see what software they've written

  Scenario: List all repositories
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut ls mdippery`
    Then it should pass with:
      """
      3ddv
      blackout
      bucknellbug
      chameleon
      collections
      dnsimple-python -> tbunnyman/dnsimple-python
      dotfiles
      glitz
      homebrew-self
      karmanaut
      libtar
      nginx.vim -> vim-scripts/nginx.vim
      rack-pesticide
      rainyday
      reponaut
      Smyck-Color-Scheme -> hukl/Smyck-Color-Scheme
      snodes
      squash
      stackim
      staticgenerator -> mrj0/staticgenerator
      usaidwat
      vimfiles
      whitman
      zanegort
      """

  Scenario: List all repositories without forks
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut ls -f mdippery`
    Then it should pass with:
      """
      3ddv
      blackout
      bucknellbug
      chameleon
      collections
      dotfiles
      glitz
      homebrew-self
      karmanaut
      libtar
      rack-pesticide
      rainyday
      reponaut
      snodes
      squash
      stackim
      usaidwat
      vimfiles
      whitman
      zanegort
      """

  Scenario: Describe all repositories
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut ls -d mdippery`
    Then it should pass with:
      """
      3ddv
          NEES 3D Data Viewer from the Center for Earthquake Engineering Simulation at RPI

      blackout
          Activate your Mac OS X screen saver with a simple keystroke

      bucknellbug
          Mac OS X weather widget that pulls info from Bucknell University's weather station

      chameleon
          Samples Stack Overflow user reputation scores

      collections
          Bringing Smalltalk and Ruby collections methods to Objective-C since 2011

      dnsimple-python -> tbunnyman/dnsimple-python
          Python client for DNSimple domain registration and DNS hosting

      dotfiles
          My configuration files

      glitz
          Track and manage your Sparkle-enabled software with a Django webapp

      homebrew-self
          My own Homebrew formulæ that aren't suitable for inclusion in the main Homebrew repo

      karmanaut
          Samples Reddit users' link and comment karma scores

      libtar
          A tarfile handling library for C and Objective-C

      nginx.vim -> vim-scripts/nginx.vim
          Ease editing of nginx conf files in Vim

      rack-pesticide
          Block annoying HTTP referrers

      rainyday
          Mac OS X screen saver that wraps Marek Brodziak's rainyday.js code

      reponaut
          Exploring the depths of GitHub

      Smyck-Color-Scheme -> hukl/Smyck-Color-Scheme
          Color Scheme for Terminal.app, iTerm2, Vim, MacVim, Sublime Text2 and Textmate

      snodes
          A distributed, encrypted file sharing network

      squash
          Minify your JavaScript, CSS, SASS, and LESS files—automagically!

      stackim
          URL shortener for Stack Overflow profiles

      staticgenerator -> mrj0/staticgenerator
          StaticGenerator for Django

      usaidwat
          Answers the age-old question, "Where does a Redditor comment the most?"

      vimfiles
          My Vim configuration

      whitman
          Sample data from JSON web APIs

      zanegort
          An IRC bot
      """

  Scenario: Describe all repositories without forks
    Given the GitHub service returns repository data for the user "mdippery"
    When I run `reponaut ls -fd mdippery`
    Then it should pass with:
      """
      3ddv
          NEES 3D Data Viewer from the Center for Earthquake Engineering Simulation at RPI

      blackout
          Activate your Mac OS X screen saver with a simple keystroke

      bucknellbug
          Mac OS X weather widget that pulls info from Bucknell University's weather station

      chameleon
          Samples Stack Overflow user reputation scores

      collections
          Bringing Smalltalk and Ruby collections methods to Objective-C since 2011

      dotfiles
          My configuration files

      glitz
          Track and manage your Sparkle-enabled software with a Django webapp

      homebrew-self
          My own Homebrew formulæ that aren't suitable for inclusion in the main Homebrew repo

      karmanaut
          Samples Reddit users' link and comment karma scores

      libtar
          A tarfile handling library for C and Objective-C

      rack-pesticide
          Block annoying HTTP referrers

      rainyday
          Mac OS X screen saver that wraps Marek Brodziak's rainyday.js code

      reponaut
          Exploring the depths of GitHub

      snodes
          A distributed, encrypted file sharing network

      squash
          Minify your JavaScript, CSS, SASS, and LESS files—automagically!

      stackim
          URL shortener for Stack Overflow profiles

      usaidwat
          Answers the age-old question, "Where does a Redditor comment the most?"

      vimfiles
          My Vim configuration

      whitman
          Sample data from JSON web APIs

      zanegort
          An IRC bot
      """

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
