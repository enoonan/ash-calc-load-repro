defmodule CalcRel.Domain.Issue do
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

    attribute :state, :atom,
      constraints: [one_of: [:needs_review, :violation, :approved, :approved_sitewide]]
  end

  relationships do
    belongs_to :site, CalcRel.Domain.Scan
  end
end
