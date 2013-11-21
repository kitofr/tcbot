defmodule TcbotTest do
  use ExUnit.Case

  import Tcbot.Tcstatus, only: [ convert_to_hashdicts: 1 ]

  test "convert" do
    json = [{"project", 
            [[{"id", "_Root"}, {"name", "<Root project>"}, {"href", "/guestAuth/app/rest/projects/id:_Root"}],
            [{"id", "AmazonApiClient"}, {"name", "Amazon API client"}, {"href", "/guestAuth/app/rest/projects/id:AmazonApiClient"}]]}]
    exct = [{:project, 
            [[{:id, "_Root"}, {:name, "<Root project>"}, {:href, "/guestAuth/app/rest/projects/id:_Root"}],
            [{:id, "AmazonApiClient"}, {:name, "Amazon API client"}, {:href, "/guestAuth/app/rest/projects/id:AmazonApiClient"}]]}]
    assert convert_to_hashdicts(json) == exct
  end
end
