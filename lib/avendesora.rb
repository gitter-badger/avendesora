# avendesora
#
# Copyright (c) 2015 Eric Will <rakaur@malkier.net>
# Rights to this code are documented in LICENSE.

# This class contains all of the app-wide stuff
class Avendesora
  # Increments for backwards-incompatible changes
  V_MAJOR = 0

  # Increments for backwards-compatible changes
  V_MINOR = 0

  # Increments for minor changes and bug fixes
  V_PATCH = 1

  # String representation of the version number
  VERSION = "#{V_MAJOR}.#{V_MINOR}.#{V_PATCH}"

  # Get us up and running
  def initialize(out = $stdout)
    out.puts "ircd: version avendesora-#{VERSION} [#{RUBY_PLATFORM}]"
  end
end
