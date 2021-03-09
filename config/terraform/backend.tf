terraform {
  backend "remote" {
    organization = "ellisio"

    workspaces {
      name = "<%= expansion('demo-:MOD_NAME-:ENV') %>"
    }
  }
}
