# SlackExport

Slack does not support export of private channels, for privacy reasons. This is a good thing.
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

It is recommended to provide a clean output directory, to avoid any file conflicts, as this utility
generates some temporary files and a single output zip file in the specified directory.

For simplicity of development (read: dev laziness), this tool still uses [Legacy Slack Tokens](https://api.slack.com/custom-integrations/legacy-tokens).
You will need to generate your own API key for the Slack account being exported and provide it to this utility.

Once you have your export, you can import back into Slack directly from your Slack admin at
https://{your-account-name}.slack.com/services/import/slack. Follow the instructions in that flow to import 
to your new Slack account.

## Future Updates

- Support export of multiple channels at a time
- Support full channel export
- Support listing of channels and interactive selection for export

## Contributing

1. Fork it ( https://github.com/mtuckergd/slack_export/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
6. Profit
