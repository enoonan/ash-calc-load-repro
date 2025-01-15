defmodule CalcRelTest do
  use ExUnit.Case
  use CalcRel.DataCase
  alias CalcRel.Domain.{Site, Page, Scan, Issue}

  test "loads nested calculations" do
    site = Ash.create!(Site, %{})
    page = Ash.create!(Page, %{site_id: site.id})
    scan = Ash.create!(Scan, %{page_id: page.id})

    scan |> Ash.load!([:foo, :bar, :baz])
    assert true
  end
end
