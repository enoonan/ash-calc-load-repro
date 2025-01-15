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

  test "calculates URL" do
    site = Ash.create!(Site, %{domain: "https://ash-hq.org"})
    page = Ash.create!(Page, %{site_id: site.id, path: "/media"})
    scan = Ash.create!(Scan, %{page_id: page.id, query_str: "?foo=bar"}) |> Ash.load!(:url)

    assert scan.url == "https://ash-hq.org/media?foo=bar"
  end

  test "loads recursive relationship normally" do
    site = Ash.create!(Site, %{domain: "https://ash-hq.org"})
    page = Ash.create!(Page, %{site_id: site.id, path: "/media"})
    scan = Ash.create!(Scan, %{page_id: page.id, query_str: "?foo=bar"}) |> Ash.load!(:url)
    Ash.create!(Issue, %{scan_id: scan.id, state: :needs_review})
    Ash.create!(Issue, %{scan_id: scan.id, state: :approved})
    Ash.create!(Issue, %{scan_id: scan.id, state: :approved_sitewide})

    scan = scan |> Ash.load!([:foo, :bar, :baz, issues: [scan: [:url]]])

    test_issue = scan.issues |> Enum.at(0)
    assert test_issue.scan.url == "https://ash-hq.org/media?foo=bar"
  end

  test "loads all relationhips and calculations from calculation which loads recursive relationship" do
    site = Ash.create!(Site, %{domain: "https://ash-hq.org"})
    page = Ash.create!(Page, %{site_id: site.id, path: "/media"})
    scan = Ash.create!(Scan, %{page_id: page.id, query_str: "?foo=bar"}) |> Ash.load!(:url)
    Ash.create!(Issue, %{scan_id: scan.id, state: :needs_review})
    Ash.create!(Issue, %{scan_id: scan.id, state: :approved})
    Ash.create!(Issue, %{scan_id: scan.id, state: :approved_sitewide})

    scan = scan |> Ash.load!([:foo, :bar, :baz, :categorized_issues, issues: [scan: [:url]]])

    approved_issue = scan.categorized_issues.approved
    assert approved_issue.scan.url == "https://ash-hq.org/media?foo=bar"
  end
end
