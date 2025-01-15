defmodule CalcRel.Domain.Scan.CategorizerCalculation do
  use Ash.Resource.Calculation

  @impl true
  def load(_, _, _),
    do: [
      :url,
      :query_str,
      issues: [
        :id,
        :state,
        scan: [:url]
      ],
      page: [site: [approved_issues: [:state]]]
    ]

  @impl true
  def calculate(records, _, _), do: records |> Enum.map(&categorize/1)

  defp categorize(scan) do
    %{
      approved: scan.issues |> Enum.filter(&(&1.state == :approved)),
      approved_sitewide: scan.issues |> Enum.filter(&(&1.state == :approved_sitewide)),
      needs_review: scan.issues |> Enum.filter(&(&1.state == :needs_review))
    }
  end
end
