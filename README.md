## Terraspace Details

- Installed `v0.6.2` via Homebrew.

## Reproduction Steps

### 1. Edit `config/terraform/backend.tf`:

Make sure to set your `organization` to a valid organization.

### 2. Ensure Fresh Slate

Run the following:

```sh
terraspace clean all -y
```

### 3. Plan dev

Run the following:

```sh
TS_ENV=dev terraspace plan project
```

### 4. Plan staging

Run the following:

```sh
TS_END=staging terraspace plan project
```

### 5. Observe the error when planning staging

The output:

```sh
Initializing modules...

Initializing the backend...

Successfully configured the backend "remote"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Reusing previous version of hashicorp/google from the dependency lock file
- Reusing previous version of hashicorp/random from the dependency lock file
- Installing hashicorp/google v3.59.0...
- Installing hashicorp/random v2.3.1...

Error: Failed to install provider

Error while installing hashicorp/google v3.59.0: the current package for
registry.terraform.io/hashicorp/google 3.59.0 doesn't match any of the
checksums previously recorded in the dependency lock file


Error: Failed to install provider

Error while installing hashicorp/random v2.3.1: the current package for
registry.terraform.io/hashicorp/random 2.3.1 doesn't match any of the
checksums previously recorded in the dependency lock file

Error running command: terraform plan -input=false
```

### 6. View `.terraform.lock.hcl` values

You can see in `.terraspace-cache/us-central1/dev/stacks/project/.terraform.lock.hcl` each provider has serveral hashes.

Now compare that to `.terraspace-cache/us-central1/staging/stacks/project/.terraform.lock.hcl`, each provider has only one hash.

### 7. Hack Fix

```sh
cd .terraspace-cache/us-central1/staging/stacks/project
rm -rf .terraform*
terraform init
```
