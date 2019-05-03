# frozen_string_literal: true

module UniteRb
  class Scope
    attr_reader :dims

    def dimensions=(dims)
      @dims = dims.each_with_object({}) do |d, acc|
        acc[d] = Dimension.new(d)
      end
    end

    def var(val, dim_name)
      dim = @dims[dim_name]
      raise UndefinedDimension.new("Dimension #{dim_name} not defined") if dim.nil?
      Var.new(val, @dims[dim_name], self)
    end

    def mul(dim_name, val)
      dim = dims[dim_name]
      ComplexDimension.new(:mul, dim, val)
    end

    def div(dim_name, val)
      dim = dims[dim_name]
      ComplexDimension.new(:div, dim, val)
    end

    def add(dim_name, val)
      dim = dims[dim_name]
      ComplexDimension.new(:add, dim, val)
    end

    def sub(dim_name, val)
      dim = dims[dim_name]
      ComplexDimension.new(:sub, dim, val)
    end

    def equate(dimarg1, dimarg2)
      dim1 = dims[dimarg1]
      dim1.set_relation(dimarg2)
    end
  end
end
