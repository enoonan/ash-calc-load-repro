# Calculation Relation Issue Reproduction

This minimally reproduces an issue wherein an error gets thrown when loading ... too many things? 

In `test/calc_rel_test.exs`, there is one test and it fails with the error in question. 

Specifically it errors when it tries to load the calculations `[:foo, :bar, :baz]`:

```elixir    
  scan |> Ash.load!([:foo, :bar, :baz])
```

If you remove one of the three calculations, it's fine. I.e., loading just `[:foo, :bar]` or just `[:foo, :baz]` or just `[:bar, :baz]` will pass the test. 

The `[:foo, :bar, :baz]` calculations are identical and look like this:

```elixir
  defmodule CalcRel.Domain.Scan.FooCalculation do
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
      records |> Enum.map(& &1.id)
    end
  end

```

The `site.approved_issues` relationship is defined like this:

```elixir 
  relationships do
    has_many :approved_issues, CalcRel.Domain.Issue do
      no_attributes? true
      public? true
      filter expr(scan.page.site_id == parent(id) and state == :approved_sitewide)
    end
  end
```
