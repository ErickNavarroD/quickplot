test_that("The output is a ggplot object",
          {expect_true(ggplot2::is.ggplot(box_jitter_plot(dataset = iris,
                                                 var_x = Species,
                                                 var_y = Sepal.Length,
                                                 x_label = "Iris species",
                                                 y_label = "Sepal length")))
            }
          ) #Test that the final output is a ggplot object

test_that("Arguments that work with categorical or numerical variables only work with the expected data types",
          {expect_error(box_jitter_plot(dataset = iris,#This should throw an error because var_x is supposed to be a categorical variable, not numerical
                                         var_x = Sepal.Length,
                                         var_y = Sepal.Length,
                                         x_label = "Iris species",
                                         y_label = "Sepal length"))
            expect_error(box_jitter_plot(dataset = iris,#This should throw an error because var_y is supposed to be a numerical variable, not categorical
                                         var_x = Species,
                                         var_y = Species,
                                         x_label = "Iris species",
                                         y_label = "Sepal length"))
            }
          )

test_that("Arguments that expect labels do not work with numerical values",
          {expect_error(box_jitter_plot(dataset = iris,
                                         var_x = Species,
                                         var_y = Sepal.Length,
                                         x_label = 123,
                                         y_label = "Sepal length"))
            expect_error(box_jitter_plot(dataset = iris,
                                         var_x = Species,
                                         var_y = Sepal.Length,
                                         x_label = "Iris species",
                                         y_label = 123 ))#This should throw an error because x_lab is supposed to be a string, not a numerical value
          }
)
