defmodule Tcbot.Tcstatus do
  
  @base_url "http://teamcity.jetbrains.com"
  alias HTTPotion.Response, as: Response

  def get(url) do
    case HTTPotion.get(url, [{ :Accept, "application/json"}]) do
      Response[body: body, status_code: status, headers: _headers ]
      when status in 200..299 ->
        { :ok, body }
      Response[body: body, status_code: _status, headers: _headers ] ->
        { :error, body }
    end
  end

  def projects do
    "#{@base_url}/guestAuth/app/rest/projects" #builds/buildType:#{project}/statusIcon"
    #"http://teamcity.jetbrains.com/project.html?projectId=#{project}&tab=projectOverview"
    #"http://teamcity.jetbrains.com/project.html?projectId=AmazonApiClient&tab=projectOverview"
  end

end

