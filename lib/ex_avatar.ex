defmodule ExAvatar do
  @moduledoc """
  Documentation for ExAvatar.
  """

  @timeout :infinity
  @letters ~w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
  @colors ~w(red blue purple)

  @letters ~w(A B C D E F G H)
  @colors ~w(red)
  def generate(opts \\ []) do
    ExAvatar.generate_names(opts)
    |> Enum.map(fn data -> ExAvatar.async_create_image(data) end)
    |> Enum.each(fn task -> Task.await(task, @timeout) end)
  end

  @doc """
  generate_names

  ## Examples

      iex> ExAvatar.generate_names(letters: "AB", colors: "red")
      [{"AA", "red"}, {"AB", "red"}, {"BA", "red"}, {"BB", "red"}]

  """
  def generate_names(opts \\ []) do
    letters =
      Keyword.get(opts, :letters, @letters)
      |> to_character_list
      |> Enum.uniq()

    colors =
      Keyword.get(opts, :colors, @colors)
      |> to_color_list
      |> Enum.uniq()

    for first <- letters,
        last <- letters,
        color <- colors,
        do: {"#{first}#{last}", color}
  end

  def async_create_image({initials, color}) do
    Task.async(fn ->
      :poolboy.transaction(
        :worker,
        fn pid -> GenServer.call(pid, {:create, initials, color}) end,
        @timeout
      )
    end)
  end

  defp to_character_list(letters) when is_binary(letters),
    do: String.split(letters, "", trim: true)

  defp to_character_list(letters) when is_list(letters), do: letters

  defp to_color_list(colors) when is_binary(colors), do: [colors]
  defp to_color_list(colors) when is_list(colors), do: colors
end
