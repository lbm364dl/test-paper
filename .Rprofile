source("renv/activate.R")

json_path <- "trackdown_access.json"
if (file.exists(json_path)) {
  # If you don't configure auth, when prompted to login with a Google account
  # for trackdown upload/download, you may otherwise get a Google error
  # "This app is blocked"
  if (requireNamespace("trackdown", quietly = TRUE)) {
    trackdown::trackdown_auth_configure(path = json_path)
  } else {
    warning(
      "Please install trackdown for Google Docs sync. You can install everything needed by simply running renv::restore()"
    )
  }
} else {
  warning(
    "Please create the file trackdown_access.json. See README.md for details."
  )
}
