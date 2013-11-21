defmodule Tcbot.Tcstatus do
  
  @base_url "http://teamcity.jetbrains.com"
  @accept_header [{ :Accept, "application/json"}]
  alias HTTPotion.Response, as: Response

  def get(url) do
    case HTTPotion.get(url, @accept_header) do
      Response[body: body, status_code: status, headers: _headers ]
      when status in 200..299 ->
        { :ok, body }
      Response[body: body, status_code: _status, headers: _headers ] ->
        { :error, body }
    end
  end

  def process do
    get(projects)
    |> decode_response
    |> convert_to_hashdicts
  end

  def decode_response({:ok, body}), do: Jsonex.decode(body)
  def decode_response({:error, msg}) do
    error = Jsonex.decode(msg)["message"]
    IO.puts "Error fetching from #{@base_url}: #{error}"
    System.halt(2)
  end

  def to_atom(v) when is_binary(v) do
    binary_to_atom(v)
  end
    
  def convert_to_hashdicts({k,v}) when !is_list v do
    IO.puts "{k,v}"
    [ to_atom(k), v ]
  end
  def convert_to_hashdicts({k,v}) when is_list v do
    IO.puts "{k,list v}"
    { to_atom(k), convert_to_hashdicts(v) }
  end
  def convert_to_hashdicts([head]) do
    IO.puts "head"
    [ convert_to_hashdicts(head) ]
  end
  def convert_to_hashdicts([head|tail]) do
    IO.puts "head|tail"
    [ convert_to_hashdicts(head), convert_to_hashdicts(tail) ]
  end

  def projects do
    "#{@base_url}/guestAuth/app/rest/projects" #builds/buildType:#{project}/statusIcon"
    #"http://teamcity.jetbrains.com/project.html?projectId=#{project}&tab=projectOverview"
    #"http://teamcity.jetbrains.com/project.html?projectId=AmazonApiClient&tab=projectOverview"
  end

end

