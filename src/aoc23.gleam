import gleam/int
import gleam/io
import gleam/list
import gleam/string
import shared

pub fn main() {
  let input = shared.read_input_file("input1.txt")
  let result = run(input)
  io.debug(result)
}

fn run(input: String) -> Int {
  let lines = string.split(input, "\n")
  let digits = list.map(lines, parse_line)
  list.fold(digits, 0, fn(acc, curr) { acc + curr })
}

fn parse_line(line: String) -> Int {
  let assert Ok(num) =
    string.to_graphemes(line)
    |> list.filter(is_digit)
    |> get_first_and_last()
    |> string.concat()
    |> int.parse()

  num
}

fn is_digit(char: String) -> Bool {
  case int.parse(char) {
    Ok(_) -> True
    Error(_) -> False
  }
}

pub fn get_first_and_last(lst: List(a)) -> List(a) {
  case lst {
    [] -> []
    [x] -> [x, x]
    [x, y] -> [x, y]
    [x, _, ..rest] -> get_first_and_last([x, ..rest])
  }
}
