local fn = vim.fn

fn.matchadd("Comment", ";;.*")

fn.matchadd("Number", "\\v[-+]?[0-9]+") -- Matches integers
fn.matchadd("Float", "\\v[-+]?[0-9]*\\.[0-9]+") -- Matches floats

fn.matchadd("String", '".*"')
fn.matchadd("Type", "\\v\\<\\(int|string\\)\\>")

fn.matchadd(
  "Operator",
  "\\v(\\+\\+|--|==|!=|<=|>=|<|>|\\|\\||&&|!|~|\\^|\\||&|=|<<|>>|\\+=|-=|\\*=|/=|%=|<<=|>>=|&=|\\|=|\\^=|\\+|-|\\*|/|%)"
)

fn.matchadd("Keyword", "SYSCALL")
fn.matchadd("Function", "exit")
