defmodule IssueTracker.GithubIssues do
  require Logger

  @user_agent [
    {"User-agent", "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:75.0) Gecko/20100101 Firefox/75.0"}
  ]
  @github_url Application.fetch_env!(:issue_tracker, :github_url)

  def fetch(user, project) do
    Logger.info("Fetching #{user}'s project #{project}")

    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    Logger.info("Status code : #{status_code}")

    {
      status_code |> check_for_errors(),
      body |> Poison.Parser.parse!()
    }
  end

  defp check_for_errors(200), do: :ok
  defp check_for_errors(_), do: :error
end
