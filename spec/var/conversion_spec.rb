# frozen_string_literal: true

require "spec_helper"

describe "Variable conversion" do
  let(:scope) do
    s = UniteRb::Scope.new
    s.dimensions= [:s, :min, :m]
    s
  end
  let(:var) { scope.var(4, :min) }

  context "when converting to an undefined unit" do
    it { expect { var.convert(:t) }.to raise_error(UniteRb::UndefinedDimension) }
  end

  context "when converting between unrelated units" do
    it { expect { var.convert(:m) }.to raise_error(UniteRb::UnrelatedDimensions) }
  end

  context "when trying to convert to the same unit" do
    it { expect(var.convert(:min).val).to eq(var.val) }
    it { expect(var.convert(:min).dim).to eq(var.dim) }
  end

  context "when converting between related units" do
    before do
      scope.equate(:min, scope.mul(:s, 60))
    end
    it { expect(var.convert(:s).val).to eq(60 * var.val) }
    it { expect(var.convert(:s).dim.name).to eq(:s) }
  end
end
