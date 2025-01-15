defmodule CalcRel.Domain.Scan.BazCalculation do
  use Ash.Resource.Calculation

  @impl true
  def load(_, _, _),
    do: [
      issues: [
        :id,
        :state
      ],
      page: [site: [approved_issues: [:id, :state]]]
    ]

  @impl true
  def calculate(records, _, _) do
    records |> Enum.map(& &1)
  end
end
