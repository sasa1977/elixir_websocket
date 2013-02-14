defmodule ElixirWebsocket do
  use Application.Behaviour
  
  def start(_type, _args) do
    dispatch = :cowboy_router.compile([{:_, [
      {"/websocket", ElixirWebsocket.WsHandler, []},
      
      {
        "/", :cowboy_static, [
          directory: {:priv_dir, :elixir_websocket, []},
          file: "index.html",
          mimetypes: {function(:mimetypes, :path_to_mimes, 2), :default}
      ]}
    ]}])
    
    :cowboy.start_http(:http, 100, [port: 8080], [env: [dispatch: dispatch]])
  end
end
