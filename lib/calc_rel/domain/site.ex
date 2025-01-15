defmodule CalcRel.Domain.Site do
  use Ash.Resource, domain: CalcRel.Domain, data_layer: AshPostgres.DataLayer

  postgres do
    repo CalcRel.Repo
    table "sites"
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_v7_primary_key :id
    attribute :domain, :string, public?: true
  end

  relationships do
    has_many :approved_issues, CalcRel.Domain.Issue do
      no_attributes? true
      public? true
      filter expr(scan.page.site_id == parent(id) and state == :approved_sitewide)
    end
  end
end
