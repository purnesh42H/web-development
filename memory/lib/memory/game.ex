defmodule Memory.Game do
  def new do
    %{
      tiles: Enum.shuffle([%{
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
      }]),
      clicks: 0,
    }
  end

  def get_guess_tile(tiles, id) do
    Enum.find tiles, fn(tile) ->
      Map.fetch!(tile, :id) == id
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
      if Map.fetch!(tile, :id) == Map.fetch!(active, :id) or Map.fetch!(tile, :id) == Map.fetch!(guess, :id) do
        Map.put(tile, :hidden, true)
        |> Map.put(:matched, false)
      else
        tile
      end
    end
  end

  def tiles_after_match(tiles, guess, active, is_correct_match?) do
    Enum.map tiles, fn tile ->
      if Map.fetch!(guess, :id) != Map.fetch!(active, :id) and
        (Map.fetch!(tile, :id) == Map.fetch!(active, :id) or
          Map.fetch!(tile, :id) == Map.fetch!(guess, :id)) do
            Map.put(tile, :hidden, true)
            |> Map.put(:matched, true)
      else
        tile
      end
    end
  end

  def matchTile(tiles, guess_id, active_id) do
    guess = get_guess_tile(tiles, guess_id)
    active = get_guess_tile(tiles, active_id)
    tiles
    |> tiles_after_match(guess, active, Map.fetch!(active, :letter) == Map.fetch!(guess, :letter))
  end

  def client_view(game) do
    %{
      	tiles: game.tiles,
      	clicks: game.clicks
    }
  end

  def guess(game, id, active) do
    tiles = game.tiles
    |> matchTile(id, active)
    Map.put(game, :tiles, tiles)
  end

  def flip(game, id) do
    tiles = game.tiles
    |> toggle_visibility(id)
    Map.put(game, :tiles, tiles)
    |> Map.put(:clicks, Map.fetch!(game, :clicks) + 1)
  end

  def reset(game, id) do
  game
  |> Map.put(:tiles, Enum.shuffle([%{
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
    }]))
    |> Map.put(:clicks, 0)
  end
end
