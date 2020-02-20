require "../spec_helper"

describe "Tuple" do
  subject tuple_literal

  expect_ignore " "
  expect_ignore "."
  expect_ignore "asd"
  expect_ignore "{"
  expect_ignore "{a"
  expect_ignore "{}"

  expect_error "{a,", Mint::Parser::TupleLiteralExpectedClosingBracket
  expect_error "{a,b", Mint::Parser::TupleLiteralExpectedClosingBracket

  expect_ok "{a,b,c}"
end
