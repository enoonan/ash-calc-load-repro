defmodule CalcRel.Domain.Scan do
  use Ash.Resource, domain: CalcRel.Domain, data_layer: AshPostgres.DataLayer

  postgres do
    repo CalcRel.Repo
    table "scans"
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_v7_primary_key :id
    attribute :query_str, :string, public?: true
  end

  relationships do
    belongs_to :page, CalcRel.Domain.Page, public?: true
    has_many :issues, CalcRel.Domain.Issue, public?: true
  end

  calculations do
    calculate :foo, :string, CalcRel.Domain.Scan.FooCalculation, public?: true
    calculate :bar, :string, CalcRel.Domain.Scan.BarCalculation, public?: true
    calculate :baz, :string, CalcRel.Domain.Scan.BazCalculation, public?: true
    calculate :categorized_issues, :map, CalcRel.Domain.Scan.CategorizerCalculation, public?: true

    calculate :url,
              :string,
              expr(page.site.domain <> page.path <> (query_str || "")),
              public?: true
  end
end
