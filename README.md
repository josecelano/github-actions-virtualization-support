# GitHub Actions Virtualization Support Test

This project provides minimal workflows to test support for LXD and Multipass virtualization tools on GitHub Ubuntu runners.

## Not supported

[![Test KVM/Libvirt Provision](https://github.com/josecelano/github-actions-virtualization-support/actions/workflows/test-kvm.yml/badge.svg)](https://github.com/josecelano/github-actions-virtualization-support/actions/workflows/test-kvm.yml)

## Supported

[![Test LXD Provision](https://github.com/josecelano/github-actions-virtualization-support/actions/workflows/test-lxd.yml/badge.svg)](https://github.com/josecelano/github-actions-virtualization-support/actions/workflows/test-lxd.yml) [![Test Multipass Provision](https://github.com/josecelano/github-actions-virtualization-support/actions/workflows/test-multipass.yml/badge.svg)](https://github.com/josecelano/github-actions-virtualization-support/actions/workflows/test-multipass.yml)

## Purpose

- Verify if LXD and Multipass can be used for full virtualization on GitHub-hosted Ubuntu runners.
- Each workflow launches a VM/container and runs a simple command inside to confirm functionality.
- Demonstrate that KVM/Libvirt fails on shared runners as expected.

## Background

- KVM/Libvirt is not supported on shared runners.
- LXD and Multipass may work, but official documentation is unclear about their virtualization capabilities.
- Related issue: [actions/runner-images#12933](https://github.com/actions/runner-images/issues/12933)
- Reference project: [torrust/torrust-tracker-deploy-rust-poc](https://github.com/torrust/torrust-tracker-deploy-rust-poc)

## Workflows

- `.github/workflows/test-lxd.yml`: Tests LXD support (should work)
- `.github/workflows/test-multipass.yml`: Tests Multipass support (should work)
- `.github/workflows/test-kvm.yml`: Tests KVM/Libvirt support (**expected to fail** - demonstrates the limitation)

## Usage

- Fork or clone this repository.
- Review workflow files for minimal LXD and Multipass tests.

## Notes

- No extra tools (like Ansible) are installed.
- Only basic VM/container creation and command execution are performed.
- The KVM/Libvirt workflow is intentionally included to show it fails with "Permission denied" errors when trying to connect to the hypervisor, confirming that full KVM virtualization is not available on shared runners.
