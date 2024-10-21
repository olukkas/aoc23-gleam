import gleam/int
import gleam/io
import gleam/list
import gleam/string
import shared

pub type Set {
  Set(red: Int, green: Int, blue: Int)
}

pub type Game {
  Game(id: Int, sets: List(Set))
}

pub fn main() {
  let file = shared.read_input_file("input2.txt")
  let input = string.split(file, on: "\n")
  let ids_valid_games =
    list.map(input, parse_line)
    |> list.filter(fn(game) { is_game_valid(game, Set(12, 13, 14)) })
    |> list.map(fn(game) { game.id - 1 })

  let assert Ok(first) = list.first(ids_valid_games)
  let sum_ids =
    list.fold(ids_valid_games, first + 1, fn(acc, curr) { acc + curr })

  io.debug(sum_ids)
}

pub fn parse_line(line: String) -> Game {
  let assert Ok(#(header, sets)) = string.split_once(line, on: ": ")
  let assert Ok(#(_, id)) = string.split_once(header, on: " ")
  let assert Ok(id) = int.parse(id)

  Game(id:, sets: parse_sets(sets))
}

fn parse_sets(set_str: String) -> List(Set) {
  let sets = string.split(set_str, "; ")
  let rounds = {
    use set <- list.map(sets)
    let plays = string.split(set, on: ", ")

    use play <- list.map(plays)
    let assert Ok(#(count, color)) = string.split_once(play, on: " ")
    let assert Ok(count) = int.parse(count)

    #(count, color)
  }

  list.map(rounds, fn(round) {
    use set, #(count, color) <- list.fold(round, Set(0, 0, 0))
    case color {
      "red" -> Set(..set, red: count + set.red)
      "green" -> Set(..set, green: count + set.green)
      "blue" -> Set(..set, blue: count + set.blue)
      _ -> set
    }
  })
}

pub fn is_game_valid(game: Game, set_reference: Set) -> Bool {
  list.all(game.sets, fn(set) {
    set.red <= set_reference.red
    && set.green <= set_reference.green
    && set.blue <= set_reference.blue
  })
}
