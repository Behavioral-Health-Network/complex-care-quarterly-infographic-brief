load_complex_care_data <- function(
) {
  etl_dir <- Sys.getenv(
    "FAMCARE_ETL_GOVERNED"
  )

  if (
    etl_dir == ""
  ) {
    stop(
      "Environment variable FAMCARE_ETL_GOVERNED is not set.",
      "Please define it in your .Renviron."
    )
  }
  # Load ETL helper environment (build subsets, fiscal date functions,
  #   cartography files, etc.)
  source(
    file.path(
      etl_dir,
      "etl/setup.R"
    ),
    local = environment()
  )
  
  store_path <- file.path(
    etl_dir,
    "_targets"
    )
  
  # Run tar_make() inside the ETL repo directory
  old_dir <- getwd()
  on.exit(
    setwd(
      old_dir
      ),
    add = TRUE
    )
  
  setwd(
    etl_dir
    )
  
  # Ensure ETL is up to date
  targets::tar_make(
    store = store_path
    )
  
  # Read the ETL output for BCR
  complex_care_data <- targets::tar_read(
    complex_care_etl,
    store = store_path
    )
  
  cartography_data <- targets::tar_read(
    cartography_bundle,
    store = store_path
    )

  ccsr_dx_lut <- targets::tar_read(
    ccsr_dx_lut,
    store = store_path
  )

  return(
    list(
      complex_care_data = complex_care_data,
      cartography_data = cartography_data,
      ccsr_dx_lut = ccsr_dx_lut
    )
  )
}