defmodule CalcRel.Domain do
  use Ash.Domain

  resources do
    resource CalcRel.Domain.Site
    resource CalcRel.Domain.Page
    resource CalcRel.Domain.Scan
    resource CalcRel.Domain.Issue
  end
end
