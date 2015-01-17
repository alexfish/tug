# Tug

![icon](icon.png)

Build and deploy iOS applications

[![Build Status](https://travis-ci.org/alexfish/tug.svg?branch=feature%2Fbuild)](https://travis-ci.org/alexfish/tug)
[![Code Climate](https://codeclimate.com/github/alexfish/tug/badges/gpa.svg)](https://codeclimate.com/github/alexfish/tug)
[![Test Coverage](https://codeclimate.com/github/alexfish/tug/badges/coverage.svg)](https://codeclimate.com/github/alexfish/tug)

## Installation

Add this line to your application's Gemfile:

    gem 'tug'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tug

## Config

tug will look in the current directory for a `.tug.yml` config file by default, use the `--config` option to pass a path to your config file if it's in a different folder. 

A sample config file:

```
project:
  workspace: tug.xcworkspace     # Path to the project workspace
  schemes:                       # An array of schemes to build
    - tug
```


## Commands

### Build

Build from your Xcode projects root directory. Each scheme in the scheme config array will be built.

```
$ tug build
```

##### Options

```
-c, [--config]     # the tug config file to use (optional, defaults to .tug.yml)
```

### IPA

Generate an ipa from your Xcode projects root directory, see the example config below for details on how to set a configuration and profile name. An ipa will be generated for each scheme in the config's scheme array.

```
$ tug ipa
```

##### Options

```
-c, [--config]        # the tug config file to use (optional, defaults to .tug.yml)
-e, [--export]        # the directory to export the .ipa to (optional, defaults to current directory)
-b, [--build-config]  # the xcode config to use to build the ipa (optional, defaults to Release)
```

### Deploy

Distrubute your builds to external services using the `deploy` command

#### Testflight

```
$ tug ipa
$ tug deploy testflight
```


###### Options

```
-f, [--file]          # path to an ipa to deploy (optional, searches current directory by default)
-a, [--api-token]     # testflight api token (optional, environmental variable by default)
-t, [--team-token]    # testflight tea, token (optional, environmental variable by default)
-l, [--lists]         # testflight distrubution lists to send the buld to (optional, defaults to none)
-n, [--notify]        # notify testflight users of the new build (optional, defaults to false)
-r, [--release-notes] # release notes for the build, can be plain text or a path to a file (optional)
```

> 
> The following environment variables are used to set your testflight API and team tokens
> * `TUG_TESTFLIGHT_API_KEY`
> * `TUG_TESTFLIGHT_TEAM_KEY`

#### Hockeyapp

```
$ tug ipa
$ tug deploy hockeyapp
```

###### Options

```
-f, [--file]              # path to an ipa to deploy (optional, searches current directory by default)
-a, [--api-token]         # hockeyapp api key (optional, environmental variable by default)
-n, [--notify]            # notify users of the new build (optional, defaults to 0)
-r, [--release-notes]     # release notes for the build, can be plain text or a path to a file (optional)
-y, [--notes-type]        # the format of the notes (optional, defaults to 1 for markdown)
-s, [--status]            # the hockeyapp download status (optional)
-t, [--tags]              # restrict the download to a list of hockeyapp tags (optional)
-e, [--teams]             # restirct the download to a list of hockeyapp teams (optional)
-u, [--users]             # restirct the download to a list of hockeyapp user ids (optional)
-m, [--mandatory]         # set as a mandatory build (optional)
-l, [--release-type]      # set the type of the release (optiona, defaults to 0 for beta)
-p, [--private]           # set if the build is private (optional, defaults to false)
-h, [--commit-sha]        # set the sha associated with this build (optional)
-u, [--build-server-url]  # set the URL of the build that generated the ipa (optional)
-p, [--repository-url]    # set the URL of the repo associated with the project (optional)
```

> 
> The following environment variable is used to set your hockeyapp API key
> * `TUG_HOCKEYAPP_API_KEY`

### Provision

> :warning: Beware of running this command on a local dev machine, this should only be run on CI servers as your keychain is altered.

Tug can provision a new machine ready for signing ipas by installing the certificates and provisioning profile required for generating a signed ipa of your application, this is very useful for CI environments like Travis. 

```
$ tug provision
```

##### Options

```
-c, [--config]         # the tug config file to use (optional, defaults to .tug.yml)
-k, [--keychain]       # the keychain to install the certificates to (optional, defaults to tug)
-p, [--password]       # the password required to access your .p12 private key (optional, environment variable by default)
```

> The following environment variable is used to set your .p12 private key password
> * `TUG_P12_PASSWORD`

#### Config 

Provisioning requires you to export the following files from your keychain and place them within your project directory:

* Apple Worldwide Developer Relations Certificate
* iPhone Distribution Certificate
* iPhone Distribution Private Key
* Distribution Provisioning Profile

Provisioning also requires a `keychain` object in the config yaml file to specify the path to the exported provisioning certificates and profile:

```
keychain:
  apple_certificate: certs/apple.cer
  distribution_certificate: certs/dist.cer
  distribution_profile: certs/profile.mobileprovision
  private_key: certs/dist.p12
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
