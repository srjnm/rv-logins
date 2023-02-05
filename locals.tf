locals {
  count = 3
  passwords = [ for k, v in random_password.ps : v.result ]
}
