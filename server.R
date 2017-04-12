
shinyServer(function(input, output) {
  output$displot <- renderPlot({
    
    on <- rep(FALSE, length(cat_cols))
    names(on) <- cat_cols
    
    sg1 <- input$selectedGroup1
    sg2 <- input$selectedGroup2
    
    if(!is.null(sg1) && sg1 != "-") {
      on[sg1] <- TRUE
    } else { sg1 <- NULL}
    
    if(!is.null(sg2) && sg2 != "-") {
      on[sg2] <- TRUE
    } else { sg2 <- NULL}
    
    make_plot(filter_dissagg(ind, on), sg1, sg2)
    
  })
})
