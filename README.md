# SlackExport

Slack does not support export of private channels, for privacy reasons.
However, your data is stil yours and you should be able to export it.
This Gem provides a utility to export your private channels in a standard Slack export format.
The export can even be imported to another Slack account as a public or private channel and
includes user accounts.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_export'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack_export

## Usage

This export utility is intended for use via command line. As such, it comes with an executable
script. After installing the Gem, run the following command to see usage:

```bash
slack_export -h
```

## Contributing

1. Fork it ( https://github.com/mtuckergd/slack_export/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
