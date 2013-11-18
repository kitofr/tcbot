defmodule Tcbot.Server do
  use GenServer.Behaviour

  def init(status) do
    { :ok, status }
  end

  def handle_call(:status, _from, status) do
    { :reply, status, check_status }
  end

  def check_status do
    :success
  end
end

