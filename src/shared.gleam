import gleam/string
import simplifile

/// looks for the input file into the 'inputs' directory
pub fn read_input_file(file_name f: String) -> String {
  let assert Ok(cwd) = simplifile.current_directory()
  let file_path = string.concat([cwd, "/inputs/", f])
  let assert Ok(content) = simplifile.read(from: file_path)

  content
}
