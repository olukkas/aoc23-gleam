import day_2.{Game, Set}
import gleam/list
import gleeunit/should

pub fn parse_game_test() {
  let expected =
    Game(id: 1, sets: [
      Set(blue: 3, red: 4, green: 0),
      Set(red: 1, green: 2, blue: 6),
      Set(green: 2, red: 0, blue: 0),
    ])

  "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
  |> day_2.parse_line()
  |> should.equal(expected)

  let expected =
    Game(id: 2, sets: [
      Set(blue: 1, green: 2, red: 0),
      Set(green: 3, blue: 4, red: 1),
      Set(green: 1, blue: 1, red: 0),
    ])

  "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"
  |> day_2.parse_line()
  |> should.equal(expected)
}

pub fn is_game_valid_test() {
  let set = Set(red: 12, green: 13, blue: 14)

  [
    "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
    "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
    "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
    "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
    "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green",
  ]
  |> list.map(day_2.parse_line)
  |> list.map(fn(game) { day_2.is_game_valid(game, set) })
  |> should.equal([True, True, False, False, True])
}

pub fn sum_test() {
  let set = Set(red: 12, green: 13, blue: 14)

  [
    "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
    "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
    "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
    "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
    "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green",
  ]
  |> list.map(day_2.parse_line)
  |> list.filter(fn(game) { day_2.is_game_valid(game, set) })
  |> list.map(fn(game) { game.id })
  |> list.fold(0, fn(a, b) { a + b })
  |> should.equal(8)
}
