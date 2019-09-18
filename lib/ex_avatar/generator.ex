defmodule ExAvatar.Generator do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, [])
  end

  def init(_) do
    {:ok, nil}
  end

  def handle_call({:create, initials, color}, _from, state) do
    size = 512

    System.cmd("convert", [
      "-font",
      "/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf",
      "-size",
      "#{size}x#{size}",
      "xc:#{color}",
      "-pointsize",
      "250",
      "-fill",
      "White",
      "-gravity",
      "center",
      "-draw",
      "text 0,0 '#{initials}'",
      "avatars/#{initials}_#{color}.png"
    ])

    {:reply, :ok, state}
  end
end
