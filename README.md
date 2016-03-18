# Icehack Packer VM Templates

An environment for use in the [Icehack](http://www.sciencefestival.cam.ac.uk/events/icehack-exploring-polar-data) event 
hosted by BAS as part of the Cambridge Science Festival 2016.

Based on templates produced by the [BAS Base Images project](https://github.com/antarctica/packer-vm-templates), 
which are in turn, based on templates from [Bento](https://github.com/opscode/bento).

## Pre-built artefacts

Pre-compiled artefacts for the current version of the pre-built environment template are listed here.

| Template             | Format               | Provider         | Distribution Method & URL                                                                                                                                                              | Notes                                                                                    |
| -------------------- | -------------------- | ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| `antarctica/icehack` | Vagrant base box     | VMware Desktop   | [Atlas](https://atlas.hashicorp.com/antarctica/boxes/icehack/versions/0.3.1) / [HTTPS](https://s3-eu-west-1.amazonaws.com/bas-icehack/environment/vagrant/baseboxes/0.3.1vmware.box)  | Supports VMware Fusion and Workstation [1] [2]                                           |
| `antarctica/icehack` | Vagrant base box     | VirtualBox       | [Atlas](https://atlas.hashicorp.com/antarctica/boxes/icehack/versions/0.3.1) / [HTTPS](https://s3-eu-west-1.amazonaws.com/bas-icehack/environment/vagrant/baseboxes/0.3.1/virtual.box) | [1] [2]                                                                                  |
| `antarctica/icehack` | OVA [3]              | VMware Desktop   | [HTTPS](https://s3-eu-west-1.amazonaws.com/bas-icehack/environment/ovas/0.3.1/vmware.ova)                                                                                              | Supports VMware Fusion, Workstation and ESXi                                             |
| `antarctica/icehack` | OVA [3]              | VirtualBox       | [HTTPS](https://s3-eu-west-1.amazonaws.com/bas-icehack/environment/ovas/0.3.1/virtualbox.ova)                                                                                          | -                                                                                        |
| `antarctica/icehack` | DigitalOcean Image   | DigitalOcean     | [Atlas](https://atlas.hashicorp.com/antarctica/artifacts/icehack/types/digitalocean.droplet/5)                                                                                         | Available only in the `lon1` region, includes private networking but not backups [1] [4] |
| `antarctica/icehack` | Amazon Machine Image | EC2              | [Atlas](https://atlas.hashicorp.com/antarctica/artifacts/icehack/types/amazon.ami/5)                                                                                                   | Available only in the `eu-west-1` region                                                 |

The recommended method to use DigitalOcean images is through [Terraform](https://www.terraform.io).

The recommended method to use EC2 AMIs is through [Terraform](https://www.terraform.io).

[1] Atlas artefacts are listed under the [Antarctica](https://atlas.hashicorp.com/antarctica) organisation.

[2] To use a base boxes list its name in a `Vagrantfile`, or follow the instructions in the
[Atlas documentation](https://atlas.hashicorp.com/help/vagrant/boxes/catalog).

[3] An OVA file is a [OVF](https://en.wikipedia.org/wiki/Open_Virtualization_Format) file compressed into a single file,
making it ideal for distribution.

[4] DigitalOcean images cannot be shared so this is not available publicly.

## Contents

  * [Icehack Packer VM Templates](#icehack-packer-vm-templates)
    * [Pre\-built artefacts](#pre-built-artefacts)
    * [Contents](#contents)
    * [Supported operating systems](#supported-operating-systems)
      * [Operating system customisations](#operating-system-customisations)
    * [Supported providers](#supported-providers)
    * [Default user accounts (conventional)](#default-user-accounts-conventional)
      * [Default passwords](#default-passwords)
    * [Default user accounts (unconventional)](#default-user-accounts-unconventional)
      * [BAS SAN distribution location](#bas-san-distribution-location)
      * [Build environment](#build-environment)
      * [Artefact indexes](#artefact-indexes)
      * [Accessing template information from within instances](#accessing-template-information-from-within-instances)
    * [Building artefacts](#building-artefacts)
      * [Artefact formats](#artefact-formats)
        * [Vagrant base boxes](#vagrant-base-boxes)
        * [OVA files](#ova-files)
        * [DigitalOcean images](#digitalocean-images)
        * [Amazon Machine Images (AMIs)](#amazon-machine-images-amis)
      * [Requirements](#requirements)
    * [Setup](#setup)
    * [Usage](#usage)
      * [Standard builds](#standard-builds)
      * [Manual builds](#manual-builds)
    * [Packaging/Distribution](#packagingdistribution)
      * [Vagrant base boxes](#vagrant-base-boxes-1)
        * [Artefact lists](#artefact-lists)
        * [Atlas](#atlas)
        * [S3](#s3)
        * [BAS SAN](#bas-san)
      * [OVA files](#ova-files-1)
        * [VirtualBox (virtualbox\-iso)](#virtualbox-virtualbox-iso)
        * [VMware (vmware\-iso)](#vmware-vmware-iso)
        * [S3](#s3-1)
        * [BAS SAN](#bas-san-1)
      * [DigitalOcean images](#digitalocean-images-1)
      * [Amazon Machine Images](#amazon-machine-images)
    * [Acknowledgements](#acknowledgements)
    * [Contributing](#contributing)
    * [Feedback](#feedback)
    * [Developing](#developing)
      * [Project management](#project-management)
      * [Committing changes](#committing-changes)
      * [Issue tracking](#issue-tracking)
      * [License](#license)

## Supported operating systems

Active support is provided for these operating systems, for the versions specified.
See the *pre-built artefacts* section for distribution/download links.

| Template Name        | Template Version | Distribution Name                | Distribution Version | Distribution Architecture | Notes   |
| -------------------- | ---------------- | -------------------------------- | -------------------- | ------------------------- | ------- |
| `antarctica/icehack` | 0.3.1            | [Ubuntu](http://www.ubuntu.com/) | 14.04 LTS (Trusty)   | AMD 64                    | [1]     |

Note: As using the `/` character is problematic with file systems an alternative template using a `-` character is used
instead. For example a template named `antarctica/trusty` would alternatively be referred to as `antarctica-trusty`.

[1] This template is based on the `antarctica/trusty` template from the BAS Base Images project.

### Operating system customisations

Some customisations are made to these Operating systems using provisioning scripts and installation options, these are
summarised below:

| Template Name(s)     | Since       | Customisation            | Rational                                                          | Applicable Artefact Formats | Notes |
| -------------------- | ----------- | ------------------------ | ----------------------------------------------------------------- | --------------------------- | ----- |
| `antarctica/icehack` | 0.1.0       | Default users            | For easier logins using passwords rather than public/private keys | *ALL*                       | -     |
| `antarctica/icehack` | 0.1.1       | Jupyter firewall rule    | To allow access to Jupyter notebook application by default        | *ALL*                       | -     |
| `antarctica/icehack` | 0.2.0       | Adding R language        | For running R flavoured notebooks through Jupyter                 | *ALL*                       | -     | 
| `antarctica/icehack` | 0.3.0       | Daemonising Jupyter      | To prevent users having to have a terminal running to use Jupyter | *ALL*                       | -     |
| `antarctica/icehack` | 0.3.0       | Reverse proxying Jupyter | To expose Jupyter on a conventional port and utilise encryption   | *ALL*                       | -     |

Note: The above list does not include customisations made by the Bento project or the BAS Base Images project.

## Supported providers

Active support is provided for a range of desktop and cloud providers, for the versions specified.

| Provider            | Vendor              | Provider Version | Notes                                        |
| ------------------- | ------------------- | ---------------- | -------------------------------------------- |
| VMware Fusion (Pro) | VMware              | 8.1.0            | [1]                                          |
| VMware Workstation  | VMware              | 12.1.0           | [1]                                          |
| VMware ESXi         | VMware              | 6.0              | And associated products such as vCentre. [1] |
| VirtualBox          | Oracle              | 5.0.14           | -                                            |
| DigitalOcean        | DigitalOcean        | -                | -                                            |
| EC2                 | Amazon Web Services | -                | -                                            |

[1] Because VMware Tools is not forwards compatible you must use a version of the relevant VMware product equal or lower
than shown in this table. This is a VMware limitation, not with Packer, Bento or us.

## Default user accounts (conventional)

Each artefact will contain one or more conventional user accounts, depending on the artefact provider. 
These user accounts are consistent across all supported operating systems.

These accounts are designed to provide generic access to virtual machines, without needing to create accounts for 
specific individuals.

Note: Artefacts may contain additional default accounts, which are unconventional, and not controlled by this project.

| Provider            | Username    | Privileged (Sudo) | Authorised Keys                             | Notes |
| ------------------- | ----------- | ----------------- | ------------------------------------------- | ----- |
| VMware Fusion (Pro) | `vagrant`   | Yes               | Vagrant shared insecure identity            | [1]   |
| VMware Fusion (Pro) | `user`      | No                | None                                        | [3]   |
| VMware Fusion (Pro) | `superuser` | Yes               | None                                        | [3]   |
| VMware Workstation  | `vagrant`   | Yes               | Vagrant shared insecure identity            | [1]   |
| VMware Workstation  | `user`      | No                | None                                        | [3]   |
| VMware Workstation  | `superuser` | Yes               | None                                        | [3]   |
| VMware ESXi         | `vagrant`   | Yes               | Vagrant shared insecure identity            | [1]   |
| VMware ESXi         | `user`      | No                | None                                        | [3]   |
| VMware ESXi         | `superuser` | Yes               | None                                        | [3]   |
| VirtualBox          | `vagrant`   | Yes               | Vagrant shared insecure identity            | [1]   |
| VirtualBox          | `user`      | No                | None                                        | [3]   |
| VirtualBox          | `superuser` | Yes               | None                                        | [3]   |
| DigitalOcean        | `terraform` | Yes               | BAS AWS Core Provisioning Identity          | [2]   |
| DigitalOcean        | `user`      | No                | None                                        | [3]   |
| DigitalOcean        | `superuser` | Yes               | None                                        | [3]   |
| EC2                 | `terraform` | Yes               | BAS DigitalOcean Core Provisioning Identity | [2]   |
| EC2                 | `user`      | No                | None                                        | [3]   |
| EC2                 | `superuser` | Yes               | None                                        | [3]   |

[1] This identity is shared between all Vagrant users and so is inherently insecure. This is used for creating Vagrant
base box artefacts, but will also be present in any OVA based artefacts as these are built from the same source VM.
More information on this identity is available [here](https://github.com/mitchellh/vagrant/tree/master/keys).

[2] This identity is shared, and restricted to, relevant BAS Staff. Contact the Web & Applications Team for access.

[3] This user is intended for general day-to-day use.

[4] This user is intended for administration purposes only.

### Default passwords

| Username    | Password      | Notes                        |
| ----------- | ------------- | ---------------------------- |
| `user`      | `icehack`     | -                            |
| `superuser` | `Ahh-a-seal!` | Passwords are case-sensitive |

## Default user accounts (unconventional)

These accounts are specific to a single artefact and are present in the underlying source artefacts used in this 
project.

E.g. The Ubuntu EC2 artefact is based on the Ubuntu official AMI, which contains a pre-configured `ubuntu` user.

Note: These unconventional accounts are not removed by this project. If needed this must be performed manually or, 
ideally, using automated provisioning.

| Provider     | Template            | Username | Privileged (Sudo) | Authorised Keys              | Notes |
| ------------ | ------------------- | -------- | ----------------- | ---------------------------- | ----- |
| EC2          | `antarctica/trusty` | `ubuntu` | Yes               | Defined at instance creation |       |
| DigitalOcean | `antarctica/trusty` | `root`   | Yes               | Defined at instance creation | [1]   |

[1] Be careful about provisioning steps which may configure SSH to refuse root logins. Without additional privileged 
users it will be impossible to connect to such instances, including to create additional users.

### BAS SAN distribution location

BAS Staff can also access these artefacts from the BAS SAN by replacing
`https://s3-eu-west-1.amazonaws.com/bas-icehack/environment` in any HTTPS link with 
`/data/softwaredist/scratch/icehack/environment`.

For example...

`https://s3-eu-west-1.amazonaws.com/bas-icehack/ovas/2.0.0/virtualbox.ova`

...would become

`/data/softwaredist/scratch/icehack/ovas/2.0.0/virtualbox.ova`

Note: The BAS SAN is used as the canonical storage location for records management.

### Build environment

The following software versions were used to produce these artefact's:

* Mac OS X: version `10.10.5`
* VirtualBox: version `5.0.14` (with version `5.0.14` of the VirtualBox Guest Additions)
* VMware Fusion Pro: version `8.1.0` (with bundled VMware Tools version)
* Packer: version `0.8.6`

### Artefact indexes

A JSON file is provided for each template containing Vagrant base box artefacts. It lists, for each artefact version,
the HTTPS distribution URL, SHA1 checksum of the box and the provider it targets.

Note: These indexes are not supported, they are provided for legacy reasons when Vagrant base boxes were self hosted.
They may be removed at any time.

| Template Name        | Index URL                                                                                                       | Notes |
| -------------------- | --------------------------------------------------------------------------------------------------------------- | ----- |
| `antarctica/icehack`  | [HTTPS](https://s3-eu-west-1.amazonaws.com/bas-icehack/environment/vagrant/baseboxes/antarctica-icehack.json)  | -     |

### Accessing template information from within instances

Templates include details about themselves in an INI formatted meta-data file. This is useful for querying the version 
of a template used in an instance for a system inventory for example.

Meta-data Location: `/etc/ansible/facts.d/os_template.fact`

Meta-data contents:

| Key        | Represents                | Example             | Notes |
| ---------- | ------------------------- | ------------------- | ----- |
| *name*     | Template name             | `antarctica/trusty` | -     |
| *name_alt* | Alternative template name | `antarctica-trusty` | -     |
| *version*  | Template version          | `3.1.0`             | -     |

Note: All meta-data is grouped under a `general` section.

Note: This meta-data is stored to be compatible with Ansible 
[Local Facts](http://docs.ansible.com/ansible/playbooks_variables.html#local-facts-facts-d) but can be used for other
purposes as needed.

## Building artefacts

Artefacts are created by running the templates defined in this project through Packer. Manual or automatic methods are
then used to package and release artefacts for distribution.

Note: If you simply wish to use an artefact from this project please see the *Pre-built artefacts* section.

### Artefact formats

Multiple artefacts are produced for each template. These include Vagrant base boxes, OVA files and various images for
cloud providers.

#### Vagrant base boxes

A specially packaged Virtual Machine for use with [Vagrant](https://www.vagrantup.com).

Packer builds base boxes from a downloaded ISO file, which it installs into a VM and then configures.

Base boxes have to meet certain criteria to be compatible with Vagrant. For templates in this project support for this
is provided by the Bento project. Base boxes are provider specific and in some cases require additional Vagrant plugins
before they can be used. For more information see the [Vagrant documentation](https://docs.vagrantup.com/v2/).

Packer will package base boxes and upload them to Atlas automatically for distribution. Boxes will need to be manually
copied to Amazon S3 (for HTTPS distribution) and the BAS SAN (for BAS SAN distribution).

#### OVA files

A compressed [OVF](http://en.wikipedia.org/wiki/Open_Virtualization_Format) image for use with most virtualisation
products.

OVA files are produced as a by-product of Vagrant base boxes, they are therefore identical except in how they are
packaged. This means OVA files are built from the same ISO file and include things required for Vagrant, such as a
`vagrant` user and password-less sudo.

Packer will create OVA files for some providers, whereas others require manual creation. OVAs will need to be manually
copied to Amazon S3 (for HTTPS distribution) and the BAS SAN (for BAS SAN distribution).

#### DigitalOcean images

A DigitalOcean image represents the saved state of a previously created Droplet (VM) from which new Droplets can be
based upon.

Packer builds DigitalOcean images using one the pre-defined base images provided by DigitalOcean to create a new
Droplet. It then configures the droplet, saves it as an image with the users DigitalOcean account before destroying the
Droplet.

The base images used are indicated below, they are minimal installations of each Operating System provided by
DigitalOcean. These images differ little from VMs produced using ISO files, except where required to run under
DigitalOcean.

| Template name        | Base Image          | Base Image Version | Provider     | Notes |
| -------------------- | ------------------- | ------------------ | ------------ | ----- |
| `antarctica/icehack` | `antarctica/trusty` | 3.3.0              | DigitalOcean | -     |

Packer will create Artefacts to reference DigitalOcean images in Atlas automatically.

#### Amazon Machine Images (AMIs)

An Amazon Machine Image represents the saved state of previously created Amazon EC2 instance (VM) from which new
instances can be based upon.

Packer builds AMIs using one of the pre-defined, public, AMIs provided through the Amazon AMI Marketplace to create a
new EC2 instance. It then configures the instance, saves it as an AMI within the users Amazon Web Services account
before terminating the instance.

The base AMIs used are indicated below, they are official, minimal, installations of each Operating System provided by
the relevant distribution. These AMIs differ little from VMs produced using ISO files, except where required to run
under EC2. One difference is the absence of a `vagrant` user, as this is not needed for cloud images.

| Template name        | Base AMI       | Provider                | Notes                                                         |
| -------------------- | -------------- | ----------------------- | ------------------------------------------------------------- |
| `antarctica/icehack` | `ami-c7229db4` | BAS Base Images project | Base AMI corresponds to `antarctica/trusty` AMI version 3.3.0 |

Packer will create Artefacts to reference AMIs in Atlas automatically.

Note: Additional elements required to use an EC2 instance, as such security groups, SSH keys, etc. are not defined as
part of the AMI. These additional elements will therefore need to be provided at runtime, ideally through a provisioning
tool.

### Requirements

To build artefacts from these template you will need the following software installed locally:

* Mac OS X or Linux
* [Packer](http://www.packer.io/docs/installation.html) `brew cask install packer` [1]
* [VirtualBox](http://www.virtualbox.org) `brew cask install virtualbox` [1]
* [VMware Fusion](http://www.vmware.com/products/fusion) `brew cask install vmware-fusion` [1]
or [VMware Workstation](http://www.vmware.com/products/workstation) [3]
* [Ovftool](https://www.vmware.com/support/developer/ovf/) [2]

You will also need:

* An `ATLAS_TOKEN` environment variable set to your [Atlas access token](https://atlas.hashicorp.com/settings/tokens)
* An `DIGITALOCEAN_API_TOKEN` environment variable set to your DigitalOcean personal access token [4]
* An `AWS_ACCESS_KEY_ID` environment variable set to your AWS access key ID, and both `AWS_ACCESS_KEY_SECRET` and
`AWS_SECRET_ACCESS_KEY` environment variables set to your AWS Access Key [5]
* Suitable permissions within AWS to create/destroy EC2 instances, AMIs, security groups, key-pairs, etc.
* Access to the `bas-icehack` S3 bucket
* A private key with access to `bslcene.nerc-bas.ac.uk` located as `~/.ssh/id_rsa` [6]
* Write access to the `/data/softwaredist` volume [7]

If testing Vagrant base boxes you will also need:

* [Vagrant](http://www.vagrantup.com) `brew cask install vagrant` [1]
* [Vagrant VMware plugin](www.vagrantup.com/vmware) `vagrant plugin install vagrant-vmware-fusion` [3]

[1] `brew cask` is a binary package manager for Mac OS X, you may need to find these applications yourself.

[2] On Mac OS X you will probably need to add this directory to your path, `PATH="/Applications/VMware OVF Tool:$PATH"`

[3] If testing Vagrant base boxes on Linux install `vagrant-vmware-workstation` instead.

[4] Specifically for a user account delegated from the *basweb@bas.ac.uk* team account.

[5] Specifically for a user account delegated from the BAS AWS account, use the
[IAM Console](https://console.aws.amazon.com/iam/home?region=eu-west-1) to generate access keys.

[6] See [here](https://help.github.com/articles/generating-ssh-keys/) for instructions on how to generate a private key,
contact the [BAS ICT helpdesk](mailto:helpdesk@bas.ac.uk) if need help enabling this key to access BAS servers.

[7] Contact the [BAS ICT helpdesk](mailto:helpdesk@bas.ac.uk) if you don't have this access.

## Setup

Clone and enter this project:

```shell
$ git clone git@github.com:antarctica/icehack-packer-templates.git
$ cd icehack-packer-templates
```

## Usage

### Standard builds

If you are generating all templates within this project, this is known as a *standard build*.

As this involves preparation, running packer, followed by packaging and release steps, a shell script to automate as 
much of this process is included for convenience.

This shell script is designed for this use-case only. It is not intended to be configurable or flexible to meet any
custom needs.

To launch the script - which is non-interactive once template versions have been specified, run:

```shell
$ ./standard-build.sh
```

Note: The standard build script does not update artefact lists, you will need to do this manually using the SHA1 hashes
generated by the script.

### Manual builds

Each template within this project is split into multiple template files, each targeting different artefact formats:

* `-desktop` templates build *Vagrant base boxes* and *OVA files*
* `-cloud` templates build *DigitalOcean images* and *AMIs*

Template files are built separately using the `packer build` command, typically all template files for a template will
be built.

Note: You **MUST** set the `release_version` user variable in each template file using 
[semantic versioning](http://semver.org/spec/v2.0.0.html).

```shell
$ packer build -var 'release_version=[Template version]' templates/[Template alternate name]-[Template file (desktop/cloud)]
```

E.g.

```shell
$ packer build -var 'release_version=1.2.3' templates/antarctica-trusty-desktop.json
```

Note: You can tell Packer to use a single builder (provider) using the `-only` option.

E.g.

```shell
$ packer build -only=vmware-iso -var 'release_version=1.2.3' templates/antarctica-trusty-desktop.json
```

## Packaging/Distribution

Some artefact formats are packaged and uploaded for distribution automatically by Packer, for other formats manual
packaging and/or uploading is required.

Note: You do not need to do this if you have used the standard build script, *except* for the artefact lists.

### Vagrant base boxes

Packer will automatically compress and package Vagrant base boxes as required.

#### Artefact lists

A JSON file is provided for each template containing Vagrant base box artefacts. It lists, for each artefact version,
the HTTPS distribution URL, SHA1 checksum of the box and the provider it targets.

Add a new entry to the relevant artefact list in `artefacts/vagrant-base-boxes/artefact-lists`, following the pattern
for previous releases. You will need to calculate an SHA1 hash for each `.box` file [1].

The `bas-icehack` bucket is used to hold these lists. This bucket is stored under the BAS AWS account and should
be accessible to all account users by default. If this is not the case please get in touch using the information in the
*feedback* section.

Note: This bucket has a permissions policy to allow anonymous read on all objects (but not directories or ACLs).

Artefact lists should be stored using the following directory and file name structure:

```shell
$ duck --username $AWS_ACCESS_KEY_ID --password $AWS_ACCESS_KEY_SECRET --region eu-west-1 --upload s3://bas-icehack/environment/vagrant/baseboxes/[Template alternate name].json artefacts/vagrant-base-boxes/artefact-lists/[Template alternate name].json
```

[1] on Mac OS X you can use `$ openssl sha1 <file>`.

#### Atlas

Packaged base boxes will be uploaded to Atlas automatically (this may take some time, base boxes are roughly 500MB each).
Uploaded artefacts will be versioned using the `release_version` user variable set in the Packer template file.
Artefacts for each provider are grouped by release.

Additional meta-data will need to be manually added to provide a relevant change log since the last version.

#### S3

Amazon S3 is used an external alternative to Atlas in case this service becomes unsuitable in the future (due to
pricing, feature changes, etc.).

The `bas-icehack` bucket is used to hold base box artefacts. This bucket is stored under the BAS AWS account and
should be accessible to all account users by default. If this is not the case please get in touch using the information
in the *feedback* section.

Note: This bucket has a permissions policy to allow anonymous read on all objects (but not directories or ACLs).

Base boxes should be stored using the following directory and file name structure:

```shell
$ duck --username $AWS_ACCESS_KEY_ID --password $AWS_ACCESS_KEY_SECRET --region eu-west-1 --upload s3://bas-icehack/environment/vagrant/baseboxes/[Artefact version]/[Base box provider].box artefacts/vagrant-base-boxes/base-boxes/[Template alternate name]/[Packer builder].box
```

#### BAS SAN

The BAS SAN is used an internal alternative to Atlas in case this service becomes unsuitable in the future (due to
pricing, feature changes, etc.). This location also acts as the canonical storage location for records management.

The `/data/softwaredist` SAN volume is used to hold base box artefacts. This volume is writeable to all members of the
`swpack` Unix group, which should include all relevant staff. Contact the [BAS ICT helpdesk](mailto:helpdesk@bas.ac.uk)
if you don't have this access.

Note: This volume has a permissions policy to allow anonymous read on all directories and files.

Base boxes should be stored using the following directory structure:

```shell
$ ssh bslcene.nerc-bas.ac.uk mkdir -p /data/softwaredist/scratch/icehack/environment/vagrant/baseboxes/[Artefact version]
```

Base boxes should be stored using the following file name structure:

```shell
$ duck --username $(whoami) --identity ~/.ssh/id_rsa --upload sftp://bslcene.nerc-bas.ac.uk/data/softwaredist/scratch/icehack/environment/vagrant/baseboxes/[Artefact version]/[Base box provider].box artefacts/vagrant-base-boxes/base-boxes/[Template alternate name]/[Packer builder].box
```

### OVA files

Each Packer builder differs in how OVA files are created:

#### VirtualBox (`virtualbox-iso`)

The VirtualBox provider produces an OVA file natively, therefore no extra work is needed.

See the *S3* and *BAS SAN* sub-sections of this section for instructions on distributing OVA files.

#### VMware (`vmware-iso`)

The VMware builder produces a VM directory in its native format, a `.vmx` file with associated support files.
This needs to be converted into an OVA file using the *OVFTool* utility prior to distribution.

See the *S3* and *BAS SAN* sub-sections of this section for instructions on distributing OVA files.

Note: Due to a bug, the `.vmx` file must be first converted to an OVF package, then into an OVA file using these steps:

```shell
$ cd [VMX directory]

$ mkdir scratch
$ ovftool vmware.vmx scratch/vmware.ovf
$ cd scratch
$ tar cf ../vmware.ova vmware.ovf vmware.mf vmware-disk1.vmdk
$ cd ..
$ ovftool --schemaValidate vmware.ova
$ rm -rf scratch
```

Where: `[VMX directory]` is the path containing the `.vmx` file.

Note: If `ovftool --schemaValidate` fails the OVA file will not work when deployed into a VMware product.

#### S3

The `bas-icehack` bucket is used to hold OVA artefacts. This bucket is stored under the BAS AWS account and
should be accessible to all account users by default. If this is not the case please get in touch using the information
in the *feedback* section.

Note: This bucket has a permissions policy to allow anonymous read on all objects (but not directories or ACLs).

OVA files should be stored using the following directory and file name structure:

```shell
$ duck --username $AWS_ACCESS_KEY_ID --password $AWS_ACCESS_KEY_SECRET --region eu-west-1 --upload s3://bas-icehack/environment/ovas/[Artefact version]/[Provider].ova artefacts/ovas/[Template alternate name]-[Packer builder]/[Provider].ova
```

#### BAS SAN

The BAS SAN is used as the canonical storage location for records management.

The `/data/softwaredist` SAN volume is used to hold OVA artefacts. This volume is writeable to all members of the
`swpack` Unix group, which should include all relevant staff. Contact the [BAS ICT helpdesk](mailto:helpdesk@bas.ac.uk)
if you don't have this access.

Note: This volume has a permissions policy to allow anonymous read on all directories and files.

OVA files should be stored using the following directory structure:

```shell
$ ssh bslcene.nerc-bas.ac.uk mkdir -p /data/softwaredist/scratch/icehack/environment/ovas/[Artefact version]
```

OVA files should then be stored using the following file name structure:

```shell
$ duck --username $(whoami) --identity ~/.ssh/id_rsa --upload sftp://bslcene.nerc-bas.ac.uk/data/softwaredist/scratch/icehack/environment/ovas/[Artefact version]/[Provider].ova artefacts/ovas/[Template alternate name]-[Packer builder]/[Provider].ova
```

### DigitalOcean images

Packer will automatically store DigitalOcean images within the DigitalOcean account Packer is configured to use.

### Amazon Machine Images

Packer will automatically store AMIs within the Amazon Web Services account Packer is configured to use.

## Acknowledgements

These templates are based on those found in the [Bento](https://github.com/opscode/bento) project from Chef.

Therefore 90% of any credit for this project should rightfully go to Bento. The authors of this project are incredibly
grateful for their work.

See their original notice file, `BENTO-NOTICE.md`, for further licensing information.

## Contributing

This project welcomes contributions, see `CONTRIBUTING` for our general policy.

## Feedback

Please log all feedback to BAS Packer Templates project:

* Please use the 'template-icehack' as a component
* If you are a BAS/NERC staff member please use our [Jira project](https://jira.ceh.ac.uk/browse/BASPACK)
* If you are external to BAS/NERC please email [webapps@bas.ac.uk](mailto:webapps@bas.ac.uk) to log feedback directly.

## Developing

### Project management

The Project Maintainer for this project is: [Felix Fennell](mailto:felnne@bas.ac.uk) [1].

[1] Please use the contact information in the *Feedback* section, rather than direct contact.

### Committing changes

The [Git flow](sian.com/git/tutorials/comparing-workflows/gitflow-workflow) workflow is used to manage the development
of this package.

* Discrete changes should be made within feature branches, created from and merged back into develop (where small
changes may be made directly)
* When ready to release a set of features/changes, create a release branch from develop, update documentation as
required and merge into master with a tagged, semantic version (e.g. v1.2.3)
* After each release, the master branch should be merged with develop to restart the process
* High impact bugs can be addressed in hotfix branches, created from and merged into master (then develop) directly

### Issue tracking

Issues, bugs, improvements, questions, suggestions and other tasks related to this project are managed through our
[Jira project](https://jira.ceh.ac.uk/browse/BASPACK) [1].

[1] Please use the contact information in the *Feedback* section to request new accounts [BAS/NERC Staff only].

### License

Copyright 2015 NERC BAS. Licensed under the Apache License for compatibility with Bento, see `LICENSE.md` for details.
