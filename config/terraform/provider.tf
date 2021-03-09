provider "google" {
  credentials = data.terraform_remote_state.tfc.outputs.google_credentials
}
