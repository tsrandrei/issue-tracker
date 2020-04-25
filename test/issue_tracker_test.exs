defmodule IssueTrackerTest do
  use ExUnit.Case
  doctest IssueTracker

  test "greets the world" do
    assert IssueTracker.hello() == :world
  end
end
