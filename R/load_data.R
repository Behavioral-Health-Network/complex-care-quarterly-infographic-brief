# Placeholder function for loading program data. Replace <program> with your
# program name and update the logic to call targets::tar_read(<program>_etl) to
# execute the ETL pipeline in `famcare-etl-goverened` and read data for the
# selected program along cartography data. Optionally, read additional data
# bundles as relevant. Refer to `_targets.R` in the `famcare-etl-governed` repo
# for available data bundles.

# load_<program>_data <- function(
# ) {
#   etl_dir <- Sys.getenv(
#     "FAMCARE_ETL_GOVERNED"
#   )
  
#   if (
#     etl_dir == ""
#   ) {
#     stop(
#       "Environment variable FAMCARE_ETL_GOVERNED is not set.",
#       "Please define it in your .Renviron."
#     )
#   }
  
#   # Load ETL helper environment (build subsets, fiscal date functions,
#   #   cartography files, etc.)
#   source(
#     file.path(
#       etl_dir,
#       "etl/setup.R"
#     ),
#     local = environment()
#   )
  
#   store_path <- file.path(
#     etl_dir,
#     "_targets"
#     )
  
#   # Run tar_make() inside the ETL repo directory
#   old_dir <- getwd()
#   on.exit(
#     setwd(
#       old_dir
#       ),
#     add = TRUE
#     )
  
#   setwd(
#     etl_dir
#     )
  
#   # Ensure ETL is up to date
#   targets::tar_make(
#     store = store_path
#     )
  
#   # Read the ETL outputs for BCR
#   <program>_data <- targets::tar_read(
#     <program>_etl,
#     store = store_path
#     )
  
#   cartography_data <- targets::tar_read(
#     cartography_bundle,
#     store = store_path
#     )

#   return(
#     list(
#       <program>_data = <program>_data,
#       cartography_data = cartography_data
#     )
#     )
# }