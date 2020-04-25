defmodule IssueTracker.CLI do
	@default_count 4

	def run(argv) do
		parse_argv(argv)
	end

	def parse_argv(argv) do
		parse = OptionParser.parse(argv, switches: [ help: :boolean ],
																		aliases: [ h: :help ])

		case parse do
			{ [ help: true ], _, _}
			  -> :help
			{ _, [ user, project, count ], _}
			  -> { user, project, String.to_integer(count)}
			{ _, [ user, project ]}
			  -> { user, project, @default_count }
			_
			  -> :help
		end
	end
end
