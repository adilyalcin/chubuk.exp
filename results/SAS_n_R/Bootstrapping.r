library(boot)

# In
# Use only TRUE large selection for analysing COMPARE task
# Use the export function in printForBootstrap to generate code to run in R
a <- c()
mean(a)
b <- boot(a, function(u,i) mean(u[i]), R = 1000)
boot.ci(b, type = c("norm", "basic", "perc", "bca"))