defmodule ElixirWebsocket.Cowboy.Server do
  def start_link do    
    dispatch = :cowboy_router.compile([{:_, [
      {"/websocket", ElixirWebsocket.Cowboy.WsHandler, []},
      {
        "/[...]", :cowboy_static, [
          directory: {:priv_dir, :elixir_websocket, []},
          mimetypes: {function(:mimetypes, :path_to_mimes, 2), :default}
      ]}
    ]}])
    
    :cowboy.start_http(:http, 100, [port: 8080], [env: [dispatch: dispatch]])
  end
end