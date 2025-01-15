defmodule CalcRel.Domain.Page do
  use Ash.Resource, domain: CalcRel.Domain, extensions: [AshPostgres.DataLayer]

  postgres do
    repo CalcRel.Repo
    table "pages"
  end

  actions do
    defaults [:read, :destroy, create: :*, update: :*]
  end

  attributes do
    uuid_v7_primary_key :id
  end

  relationships do
    belongs_to :site, CalcRel.Domain.Site
  end
end
