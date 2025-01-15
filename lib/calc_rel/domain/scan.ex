defmodule CalcRel.Domain.Scan do
  use Ash.Resource, domain: CalcRel.Domain, extensions: [AshPostgres.DataLayer]

  postgres do
    repo CalcRel.Repo
    table "scans"
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_v7_primary_key :id
  end

  relationships do
    belongs_to :site, CalcRel.Domain.Page
  end

  calculations do
    calculate :foo, :string, CalcRel.Domain.Scan.FooCalculation, public?: true
    calculate :bar, :string, CalcRel.Domain.Scan.BarCalculation, public?: true
    calculate :baz, :string, CalcRel.Domain.Scan.BazCalculation, public?: true
  end
end
