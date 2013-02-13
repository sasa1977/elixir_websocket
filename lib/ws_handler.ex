defmodule ElixirWebsocket.WsHandler do
  def init(_transport, _, []) do
    {:upgrade, :protocol, :cowboy_websocket}
  end
  
  def websocket_init(_, req, _) do
    send_messages(self)
    {:ok, req, nil}
  end
  
  defp send_messages(process) do
    Process.spawn(fn() ->
      Enum.each(1..10, fn(index) ->
        :timer.sleep(:timer.seconds(1))
        process <- {:message, "generated message #{index}"}
      end)
    end)
  end
  
  
  def websocket_handle({:text, msg}, req, state) do
    {:reply, {:text, "response to #{msg} from client"}, req, state}
  end
  
  def websocket_handle(_, req, state) do
    {:ok, req, state}
  end
  
  
  def websocket_info({:message, msg}, req, state) do
    {:reply, {:text, msg}, req, state}
  end
  
  def websocket_info(_, req, state) do
    {:ok, req, state}
  end
  

  def websocket_terminate(_, _, _) do
    :ok
  end
end