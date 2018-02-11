defmodule Memory.Game do
  def new do
  %{
    tiles: [%{
      id: "t1", letter: "D", hidden: true, matched: false
    }, %{
      id: "t2", letter: "H", hidden: true, matched: false
    }, %{
      id: "t3", letter: "B", hidden: true, matched: false
    }, %{
      id: "t4", letter: "E", hidden: true, matched: false
    }, %{
      id: "t5", letter: "C", hidden: true, matched: false
    }, %{
      id: "t6", letter: "C", hidden: true, matched: false
    }, %{
      id: "t7", letter: "E", hidden: true, matched: false
    }, %{
      id: "t8", letter: "G", hidden: true, matched: false
    }, %{
      id: "t9", letter: "F", hidden: true, matched: false
    }, %{
      id: "t10", letter: "G", hidden: true, matched: false
    }, %{
      id: "t11", letter: "H", hidden: true, matched: false
    }, %{
      id: "t12", letter: "F", hidden: true, matched: false
    }, %{
      id: "t13", letter: "D", hidden: true, matched: false
    }, %{
      id: "t14", letter: "A", hidden: true, matched: false
    }, %{
      id: "t15", letter: "B", hidden: true, matched: false
    }, %{
      id: "t16", letter: "A", hidden: true, matched: false
    }],
    clicks: 0,
  }

  def get_guess_tile(tiles, id) do
    Enum.find tiles, fn(tile) ->
      Map.fetch!(tile, :id) == id
    end
  end

  def get_active_tile(tiles) do
    Enum.find tiles, fn(tile) ->
      Map.fetch!(tile, :hidden) == false
    end
  end

  def toggle_visibility(tiles, id) do
    Enum.map tiles, fn tile ->
      if Map.fetch!(tile, :id) == id do
        tile
        |> Map.put(:hidden, false)
      else
 	      tile
      end
    end
  end

  def tiles_after_match(tiles, guess, active, is_correct_match?) when is_correct_match? == false do
    Enum.map tiles, fn tile ->
      if Map.fetch!(tile, :id) == Map.fetch!(active, :id) do
        Map.put(tile, :hidden, true)
        |> Map.put(:matched: false)
      else
        tile
      end
  end

  def tiles_after_match(tiles, guess, active, is_correct_match?) do
    Enum.map tiles, fn tile ->
      if Map.fetch!(tile, :id) == Map.fetch!(active, :id) ||
          Map.fetch!(tile, :id) == Map.fetch!(guess, :id) do
            Map.put(tile, :hidden, true)
            |> Map.put(:matched: true)
      else
        tile
      end
  end

  def matchTile(tiles, guess_id) do
    active = get_active_tile(tiles)
    guess = get_guess_tile(tiles, guess_id)
    is_correct_match? = Map.fetch!(active, :letter) == Map.fetch!(guess, letter)
    tiles = tiles
    |> toggleVisibility(id)

    if active != nil do
      tiles
      |> tiles_after_match(guess, active, is_correct_match?)
    else
      tiles
    end
  end

  def client_view(game) do
    %{
      	tiles: game.tiles,
      	clicks: game.clicks
    }
  end

  def guess(game, id) do
    tiles = game.tiles
    |> toggle_visibility(id)
    |> matchTile(id)
    Map.put(game, :tiles, tiles)
    |> Map.put(:clicks, clicks + 1)
  end

  def flip(game, id) do
    tiles = game.tiles
    |> toggle_visibility(id)
    Map.put(game, :tiles, tiles)
    |> Map.put(:clicks, clicks + 1)
  end
end
