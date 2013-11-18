defmodule Tcbot.Tcstatus do
  
  #@user_agent [ "User-agent", "Elixir kitofr@gmail.com" ]
  alias HTTPotion.Response, as: Response

  def fetch(project) do
    case HTTPotion.get(tc_url(project)) do
      Response[body: body, status_code: status, headers: _headers ]
      when status in 200..299 ->
        { :ok, body }
      Response[body: body, status_code: _status, headers: _headers ] ->
        { :error, body }
    end
  end

  def tc_url(project) do
    "http://teamcity.jetbrains.com/guestAuth/app/rest/projects" #builds/buildType:#{project}/statusIcon"
    #"http://teamcity.jetbrains.com/project.html?projectId=#{project}&tab=projectOverview"
    #"http://teamcity.jetbrains.com/project.html?projectId=AmazonApiClient&tab=projectOverview"
  end
end

