
shinyUI(pageWithSidebar(
  headerPanel('Dissaggregation Example'),
  sidebarPanel(
    selectInput('selectedGroup1', 'First Dissaggregation', c("-", cat_cols)),
    selectInput('selectedGroup2', 'Second Dissaggregation', c("-", cat_cols))
  ),
  mainPanel(
    plotOutput("displot", width = "450", height = "300"), width = 7
  )
))
