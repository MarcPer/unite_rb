# frozen_string_literal: true

require "spec_helper"
require "pry"

describe "Equality between variables" do
  let(:scope) do
    s = UniteRb::Scope.new
    s.dimensions= dimensions
    s
  end

  context "when variables don't have comparable units" do
    let(:dimensions) { %i[km s] }

    context "should raise an error" do
      let(:var1) { scope.var(100, :km) }
      let(:var2) { scope.var(100, :s) }
      it { expect { var1 == var2 }.to raise_error(UniteRb::UnrelatedDimensions) }
      it { expect { var1 > var2 }.to raise_error(UniteRb::UnrelatedDimensions) }
      it { expect { var1 < var2 }.to raise_error(UniteRb::UnrelatedDimensions) }
      it { expect { var1 >= var2 }.to raise_error(UniteRb::UnrelatedDimensions) }
      it { expect { var1 <= var2 }.to raise_error(UniteRb::UnrelatedDimensions) }
    end
  end

  context "when variables have the same unit" do
    let(:dimensions) { %i[m] }
    context "and their values are equal" do
      let(:var1) { scope.var(100, :m) }
      let(:var2) { scope.var(100, :m) }
      it { expect(var1).to eq(var2) }
      it { expect(var2).to eq(var1) }

      it { expect(var1).to be <= var2 }
      it { expect(var1).to be >= var2 }

      it { expect(var2).to be <= var1 }
      it { expect(var2).to be >= var1 }

      it { expect(var1).not_to be < var2 }
      it { expect(var1).not_to be > var2 }

      it { expect(var2).not_to be < var1 }
      it { expect(var2).not_to be > var1 }
    end

    context "and their values are not equal" do
      let(:var1) { scope.var(100, :m) }
      let(:var2) { scope.var(200, :m) }

      it { expect(var1).not_to eq(var2) }
      it { expect(var2).not_to eq(var1) }

      it { expect(var1).to be <= var2 }
      it { expect(var1).not_to be >= var2 }

      it { expect(var2).not_to be <= var1 }
      it { expect(var2).to be >= var1 }

      it { expect(var1).to be < var2 }
      it { expect(var1).not_to be > var2 }

      it { expect(var2).not_to be < var1 }
      it { expect(var2).to be > var1 }
    end
  end

  context "when variables have comparable units" do
    let(:dimensions) { %i[m km] }

    context "related through a multiplicative factor" do
      before do
        scope.equate(:km, scope.mul(:m, 1000))
      end

      context "and they are equal considering their units" do
        let(:var1) { scope.var(408, :km) }
        let(:var2) { scope.var(408_000, :m) }

        it { expect(var1).to eq(var2) }
        it { expect(var2).to eq(var1) }

        it { expect(var1).to be <= var2 }
        it { expect(var1).to be >= var2 }

        it { expect(var2).to be <= var1 }
        it { expect(var2).to be >= var1 }

        it { expect(var1).not_to be < var2 }
        it { expect(var1).not_to be > var2 }

        it { expect(var2).not_to be < var1 }
        it { expect(var2).not_to be > var1 }
      end

      context "but they are not equal considering their units" do
        let(:var1) { scope.var(407, :km) }
        let(:var2) { scope.var(408_000, :m) }

        it { expect(var1).not_to eq(var2) }
        it { expect(var2).not_to eq(var1) }

        it { expect(var1).to be <= var2 }
        it { expect(var1).not_to be >= var2 }

        it { expect(var2).not_to be <= var1 }
        it { expect(var2).to be >= var1 }

        it { expect(var1).to be < var2 }
        it { expect(var1).not_to be > var2 }

        it { expect(var2).not_to be < var1 }
        it { expect(var2).to be > var1 }
      end
    end

    context "related through a division factor" do
      before do
        scope.equate(:m, scope.div(:km, 1000))
      end

      context "and they are equal considering their units" do
        let(:var1) { scope.var(408, :km) }
        let(:var2) { scope.var(408_000, :m) }

        it { expect(var1).to eq(var2) }
        it { expect(var2).to eq(var1) }

        it { expect(var1).to be <= var2 }
        it { expect(var1).to be >= var2 }

        it { expect(var2).to be <= var1 }
        it { expect(var2).to be >= var1 }

        it { expect(var1).not_to be < var2 }
        it { expect(var1).not_to be > var2 }

        it { expect(var2).not_to be < var1 }
        it { expect(var2).not_to be > var1 }
      end

      context "but they are not equal considering their units" do
        let(:var1) { scope.var(407, :km) }
        let(:var2) { scope.var(408_000, :m) }

        it { expect(var1).not_to eq(var2) }
        it { expect(var2).not_to eq(var1) }

        it { expect(var1).to be <= var2 }
        it { expect(var1).not_to be >= var2 }

        it { expect(var2).not_to be <= var1 }
        it { expect(var2).to be >= var1 }

        it { expect(var1).to be < var2 }
        it { expect(var1).not_to be > var2 }

        it { expect(var2).not_to be < var1 }
        it { expect(var2).to be > var1 }
      end
    end

    context "related through a constant positive offset" do
      let(:dimensions) { %i[hour_utc hour_cet] }
      before do
        scope.equate(:hour_cet, scope.sub(:hour_utc, 2))
      end

      context "and they are equal considering their units" do
        let(:var1) { scope.var(10, :hour_utc) }
        let(:var2) { scope.var(12, :hour_cet) }

        it { expect(var1).to eq(var2) }
        it { expect(var2).to eq(var1) }

        it { expect(var1).to be <= var2 }
        it { expect(var1).to be >= var2 }

        it { expect(var2).to be <= var1 }
        it { expect(var2).to be >= var1 }

        it { expect(var1).not_to be < var2 }
        it { expect(var1).not_to be > var2 }

        it { expect(var2).not_to be < var1 }
        it { expect(var2).not_to be > var1 }
      end

      context "but they are not equal considering their units" do
        let(:var1) { scope.var(10, :hour_cet) }
        let(:var2) { scope.var(10, :hour_utc) }

        it { expect(var1).not_to eq(var2) }
        it { expect(var2).not_to eq(var1) }

        it { expect(var1).to be <= var2 }
        it { expect(var1).not_to be >= var2 }

        it { expect(var2).not_to be <= var1 }
        it { expect(var2).to be >= var1 }

        it { expect(var1).to be < var2 }
        it { expect(var1).not_to be > var2 }

        it { expect(var2).not_to be < var1 }
        it { expect(var2).to be > var1 }
      end
    end
  end
end

