# frozen_string_literal: true

module UniteRb
  # Bumped for major changes.
  MAJOR = 0

  # Bumped for non-patch level release.
  MINOR = 1

  # Bumped for bugfix releases.
  TINY  = 0

  # The version of UniteRb being used, as a string (e.g. "1.5.0")
  VERSION = [MAJOR, MINOR, TINY].join('.').freeze

  # The version of UniteRb being used, as a number (1.5.0 -> 10050)
  VERSION_NUMBER = MAJOR*10000 + MINOR*10 + TINY

  # The version of UniteRb you are using, as a string (e.g. "1.5.0")
  def self.version
    VERSION
  end
end
