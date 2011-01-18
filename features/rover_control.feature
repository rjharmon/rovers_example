Feature: controlling the rover
  As a NASA user
  I want to send my commands to the rovers
  So that I don't have to go to Mars myself

  Scenario: Rovers will end up in the right locations
    Given a file named "rover_commands" with:
      """
      5 5
      1 2 N
      LMLMLMLMM
      3 3 E
      MMRMMRMRRM
      """
    When I run "../../bin/rovers rover_commands"
    Then the output should contain exactly:
      """
      1 3 N
      5 1 E

      """
      # trailing newline

  

