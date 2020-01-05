# frozen_string_literal: true

module UniteRb
  class Error < ::StandardError
    attr_accessor :wrapped_exception

    if RUBY_VERSION >= '2.1'
      # Returned the wrapped exception if one exists, otherwise use
      # ruby's default behavior.
      def cause
        wrapped_exception || super
      end
    end
  end

  (
    UnrelatedDimensions = Class.new(Error)
  ).name

  (
    UnknownOperation = Class.new(Error)
  ).name

  (
    UndefinedDimension = Class.new(Error)
	).name
	
end
