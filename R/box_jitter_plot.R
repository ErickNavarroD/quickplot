#' Plot a boxplot with a jitterplot
#'
#' This function creates a boxplot with a jitter plot to observe the distribution of a numeric variable
#' across one or more categorical variables. Furthermore, the mean is denoted as a black asterisk.
#'
#'
#' @param dataset The dataset containing the variables for plotting in a tidy format. Names come from "dataset used to plot"
#' @param var_x Name of the column containing the categorical variable to be plot in x axis. Name comes from "variable x"
#' @param var_y Name of the column containing the numerical variable to be plot in y axi. Name comes from "variable y"
#' @param x_label,y_label String indicating the name of the labels for x and y axis. Names come from "label of axis x or y"
#' @param alpha_boxplot,alpha_jitter Transparency parameter of the boxplot and jitterplot. Default is set to 0.3. Names come from "alpha of boxplot or jitterplot"
#' @param width_jitter Width parameter of the jitterplot. Default is set to 0.1. Name comes from "width of jitterplot"
#' @examples
#' #Generate a box + jitter plot with the mpg dataset. The resulting plot can be further modified
#' # with ggplot2 functions to improve the visualization
#' box_jitter_plot(ggplot2::mpg,
#'     var_x = model,
#'     var_y = displ,
#'     x_label = "Car model",
#'     y_label = "Engine displacement (liters)",
#'     alpha_boxplot = 0.4,
#'     alpha_jitter = 0.4,
#'     width_jitter = 0.15) +
#' ggplot2::coord_flip()
#'
#' @return A ggplot2 histogram + jitter plot of a numerical variable with the mean marked as a black asterisk.
#' @export




box_jitter_plot <- function(dataset,
                            var_x,
                            var_y,
                            x_label,
                            y_label,
                            alpha_boxplot = 0.3,
                            alpha_jitter = 0.3,
                            width_jitter = 0.1){
  arguments_list = list(var_y = dplyr::pull(dataset, {{var_y}}),
                        alpha_boxplot = alpha_boxplot,
                        alpha_jitter = alpha_jitter,
                        width_jitter = width_jitter,
                        var_x = dplyr::pull(dataset, {{var_x}}),
                        x_label = x_label,
                        y_label = y_label)

  #Check data types: numeric data
  for(argument_name in c(names(arguments_list)[1:4])){
    if(!is.numeric(arguments_list[[argument_name]])){
      stop("Argument `", argument_name ,"` must be numeric. You input an object of class ",
           class(arguments_list[[argument_name]]))
    }
  }

  #Check data types: characters/factors
  for(argument_name in c(names(arguments_list)[5:7])){
    if(!is.character(arguments_list[[argument_name]]) && !is.factor(arguments_list[[argument_name]])){
      stop("Argument `", argument_name ,"` must be character or factor You input an object of class ",
           class(arguments_list[[argument_name]]))
    }
  }

  #Produce the plot
  dataset %>%
    dplyr::filter(!is.na({{var_x}}),
           !is.na({{var_y}})) %>%
    ggplot2::ggplot(ggplot2::aes( x = {{var_x}}, y = {{var_y}}, fill = {{var_x}})) +
    ggplot2::geom_boxplot(alpha = alpha_boxplot) +
    ggplot2::geom_jitter(alpha = alpha_jitter, width = width_jitter)+
    ggplot2::stat_summary(fun = mean, colour = "black", shape = 8) +
    ggplot2::theme_classic() +
    ggplot2::guides(fill = "none")+
    ggplot2::xlab(x_label) +
    ggplot2::ylab(y_label)

}
