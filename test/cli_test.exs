defmodule CliTest do
	use ExUnit.Case
	doctest IssueTracker

	import IssueTracker.CLI, only: [ parse_argv: 1,
	                                 sort_into_descending_order: 1 ]

	test ":help returned by options parsing with -h and -help options" do
		assert parse_argv(["-h", "anything"]) == :help
		assert parse_argv(["--help", "anything"]) == :help
	end

	test "three values returned if three given" do
		assert parse_argv([ "user", "project", "99" ]) == { "user", "project", 99 }
	end

	test "count is defaulted if two given" do
		assert parse_argv([ "user", "project" ]) == { "user", "project", 4 }
	end

	test "sort descending orders the correct way" do
		result = sort_into_descending_order(fake_created_at_list(["c", "a", "b"]))
		issue = for issue <- result, do: Map.get(issue, "created_at")
		assert issue == ~w{ c b a}
	end

	defp fake_created_at_list(values) do
		for value <- values, do: %{"created_at" => value, "other_data" => "xxx"} 
	end
end
