defmodule CalcRel.Domain.Issue do
  use Ash.Resource, domain: CalcRel.Domain, data_layer: AshPostgres.DataLayer

  postgres do
    repo CalcRel.Repo
    table "issues"
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_v7_primary_key :id

    attribute :state, :atom,
      constraints: [one_of: [:needs_review, :violation, :approved, :approved_sitewide]]
  end

  relationships do
    belongs_to :scan, CalcRel.Domain.Scan, public?: true
  end
end
