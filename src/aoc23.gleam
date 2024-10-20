import simplifile
import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub fn main() {
  let assert Ok(file_path) = simplifile.current_directory()
  let file_path = string.concat([file_path, "/inputs/input1.txt"])
  let result = run(file_path)
  io.debug(result)
}

fn run(path p: String) -> Int {
  let assert Ok(file) = simplifile.read(from: p)
  let input = string.split(file, "\n")
  let digits = list.map(input, parse_line)
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