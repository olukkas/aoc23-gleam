import gleam/string
import simplifile

pub fn read_input_file(path p: String) -> String {
  let assert Ok(dir) = simplifile.current_directory()
  let file_path = string.concat([dir, "/inputs/", p])
  let assert Ok(content) = simplifile.read(from: file_path)

  content
}