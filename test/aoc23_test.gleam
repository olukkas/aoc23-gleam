import gleeunit
import gleeunit/should
import aoc23

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn get_first_and_last_test() {
  aoc23.get_first_and_last([])
  |> should.equal([])

  aoc23.get_first_and_last([1])
  |> should.equal([1, 1])

  aoc23.get_first_and_last([1, 2])
  |> should.equal([1, 2])

  aoc23.get_first_and_last([1, 2, 3])
  |> should.equal([1, 3])
}
