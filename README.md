# Tug

![icon](icon.png)

Build and deploy iOS applications

[![Build Status](https://travis-ci.org/alexfish/tug.svg?branch=feature%2Fbuild)](https://travis-ci.org/alexfish/tug)
[![Code Climate](https://codeclimate.com/github/alexfish/tug.png)](https://codeclimate.com/github/alexfish/tug)

## Installation

Add this line to your application's Gemfile:

    gem 'tug'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tug

## Usage

### Build

Run `tug build` from your Xcode projects root directory. Each scheme in the scheme config array will be built.

### IPA

Run `tug ipa` from your Xcode projects root directory, see the example config below for details on how to set a configuration and profile name. An ipa will be generated for each scheme in the config's scheme array.

### Config

tug will look in the currenty directory for a `.tug.yml` config file by default, use the `--config` option to pass a path to your config file if it's in a different folder. 

A sample config file:

```
project:
  workspace: tug.xcworkspace     # Path to the project workspace
  schemes:                       # An array of schemes to build
    - tug
  ipa_config: Release            # The configuration to use to build ipas
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
