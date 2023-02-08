locals {
  count = 122
  passwords = [ for k, v in random_password.ps : v.result ]
}
