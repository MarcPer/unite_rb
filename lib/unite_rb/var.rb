# frozen_string_literal: true

module UniteRb
  class Var
    COMPARISON_OPERATORS = %i[== > >= < <=].freeze
    ARITHMETIC_OPERATORS = %i[+ - * /].freeze

    attr_reader :val, :dim
    def initialize(val, dim, scope)
			raise ArgumentError.new("First argument has to be of Numeric type") unless val.is_a?(Numeric)
      @val = val
      @dim = dim
      @scope = scope
    end

    def to_s
      "#{val} #{dim.name}"
    end

    def convert(dim_name)
      return self if dim.name == dim_name
      new_dim = @scope.dims[dim_name]
      raise UndefinedDimension.new("Dimension #{dim_name} not defined") if new_dim.nil?

      rel = dim.relations[dim_name]
      raise UnrelatedDimensions.new("No relation exists between dimensions #{dim.name} and #{dim_name}") if rel.nil?

      new_val = case rel.op
      when :id then val
      when :mul then val * rel.val
      when :div then val / rel.val
      when :add then val + rel.val
      when :sub then val - rel.val
      else raise UnknownOperation.new("Operation #{rel.op} unknown. It should be one of #{OPERATIONS}")
      end
      Var.new(new_val, new_dim, @scope)
    end

    COMPARISON_OPERATORS.each do |op|
      define_method(op) do |other|
        val.send(op, scaled_val(other))
      end
    end

    ARITHMETIC_OPERATORS.each do |op|
			define_method(op) do |other|
				other = Var.new(other, dim, @scope) if other.is_a?(Numeric)
        @scope.var(val.send(op, scaled_val(other)), dim.name)
      end
    end

    private

		def scaled_val(other)
      other_dim = other.dim
      rel = dim.relations[other_dim.name]
      raise UnrelatedDimensions.new("No relation exists between dimensions #{dim.name} and #{other_dim.name}") if rel.nil?
      case rel.op
      when :id then other.val
      when :mul then other.val / rel.val
      when :div then other.val * rel.val
      when :add then other.val - rel.val
      when :sub then other.val + rel.val
      else raise UnknownOperation.new("Operation #{rel.op} unknown. It should be one of #{OPERATIONS}")
			end
    end
  end
end
