context("cacls")

test_that("t_calc returns correct value", {

  expect_equal( psychlytx::t_rel(1,1,1,1,1,1), 1 )
  expect_equal( psychlytx::t_rel(1,1,1,1,0,1), NaN ) ## testing dividing by 0

})
