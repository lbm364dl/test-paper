# Create JSON token (only once per account):
# 1. Google Cloud Platform
#   -> APIs & Services
#   -> Credentials
#   -> Create credentials
#   -> OAuth client ID
#
# 2. Fill:
#   -> Application type: Desktop app
#   -> Choose a name, e.g. Trackdown
#   -> Create
#   -> Download JSON

# Full path to your downloaded JSON (it contains the credentials)
json_path <- "~/Downloads/client_secret_id.json"
# If you don't configure auth, when prompted to login with a Google account,
# you may otherwise get a Google error "This app is blocked"
trackdown::trackdown_auth_configure(path = json_path)
# Should return TRUE if auth was correct
trackdown::trackdown_has_token()

# Actual operations (always be careful with overwriting)

# Set Google doc with the content of local file
trackdown::update_file("./index.qmd")

# Set local file with the content of Google doc
trackdown::download_file("./index.qmd")
