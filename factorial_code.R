 Measure performance and create output ----------------------------------------

# Use microbenchmark and purrr package to calculate performance for different 
# input values
# input values and for ranges of input values

sink("factorial_output.txt")

cat("====== PART 1: Performance and comparison of indivudual input values ======\n")
cat("======================== across factorial functions ======================= \n\n")

# Reset lookup table for comparing purposes
fact_tbl <- c(rep(NA, 65))

results <- map(input, ~ microbenchmark(

# Calculate and compare perforamnce of individual input values
individual_results <- map(input, ~ microbenchmark(
  factorial_loop(.),
  factorial_reduce(.),
  factorial_func(.),
  factorial_mem(.)
))

names(results) <- as.character(input)
names(individual_results) <- as.character(input)
individual_results

# Calculate and compare performance of ranges of input values

cat("====== PART 2: Performance and comparison of ranges of input values =======\n")
cat("======================== across factorial functions ======================= \n\n")

get_benchmark <- function(x) {
  fact_tbl <<- c(rep(NA, 100))
  microbenchmark(map_dbl(x, factorial_loop),
                 map_dbl(x, factorial_reduce),
                 map_dbl(x, factorial_func),
                 map_dbl(x, factorial_mem))
}

ranges <- list(`range 1:10` = 1:10,
               `range 1:50` = 1:50,
               `range 1:100` = 1:100)

range_results <- map(ranges, get_benchmark)
range_results

# Write output to file
sink("factorial_output.txt")
results
sink()
