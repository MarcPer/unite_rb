# frozen_string_literal: true

module UniteRb
  class Scope
    attr_reader :dims
		def initialize
			@dims ={}
		end

		def find_add_dimension(dim)
			@dims[dim] ||  (@dims[dim] = Dimension.new(dim))
		end

    def dimensions=(dims)
			@dims = dims.each_with_object({}) do |d, acc|
        acc[d] = Dimension.new(d)
      end
    end

		def var(val, dim_name)
			find_add_dimension(dim_name)
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
			dim2 = dims[dimarg2.name]
			raise UndefinedDimension.new("Dimension #{dimarg1} not defined") if dim1.nil?
			raise UndefinedDimension.new("Dimension #{dimarg2.name} not defined") if dim2.nil?
      dim1.set_relation(dimarg2)
    end
  end
end
