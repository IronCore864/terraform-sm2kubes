# Terraform Module for CloudWatch Event Rule Triggering Lambda

This is the Cloud Infra part of [this repo](https://github.com/IronCore864/sm2kubes).

## Architecture

Secrets Manager API Call -> CloudTrail -> CloudWatch Event Rule -> Lambda -> Golang App getting secret from Secrets Manager and writing to K8s with K8s API.
