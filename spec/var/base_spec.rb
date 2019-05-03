# frozen_string_literal: true

require "spec_helper"

describe "Variable initialization" do
  let(:scope) do
    s = UniteRb::Scope.new
    s.dimensions= [:m]
    s
  end

  context "when given value is not numeric" do
    it { expect { scope.var("50", :m) }.to raise_error(ArgumentError) }
  end

  context "when dimension is not defined in scope" do
    it { expect { scope.var(50, :km) }.to raise_error(UniteRb::UndefinedDimension) }
  end
end

describe "Variable printing" do
  let(:scope) do
    s = UniteRb::Scope.new
    s.dimensions= [:"m/s"]
    s
  end
  let(:var) { scope.var(15.73, :"m/s")}

  context "when printing variable" do
    it { expect(var.to_s).to eq("15.73 m/s") }
  end
end
