# frozen_string_literal: true

module UniteRb
  class Dimension
    attr_reader :name, :relations
    def initialize(dim_name)
      @name = dim_name
      @relations = {}
      relations[dim_name] = ComplexDimension.new(:id, self, 1)
    end

    def dim
      self
    end

    def op
      :id # identity operation
    end

    def set_relation(other)
      return if relations.key?(other.name)
      relations[other.name] = other
      cd = ComplexDimension.new(ComplexDimension.invert(other.op), self, other.val)
      other.dim.set_relation(cd)
    end
  end

  class ComplexDimension < Dimension
    attr_reader :dim, :val, :op

    def self.invert(op)
      case op
      when :id then :id
      when :mul then :div
      when :div then :mul
      when :add then :sub
      when :sub then :add
      end
    end

    def initialize(op, base_dimension, base_value)
      @dim = base_dimension
      @op = op
      @val = base_value
    end

    def name
      dim.name
    end
  end
end
