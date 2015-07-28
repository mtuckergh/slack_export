require "slack_export/slack_client"
require "json"
require "zip"

module SlackExport
  class Exporter

    attr_reader :client, :channel, :base_path
    attr_accessor :logger

    def initialize(api_key, channel, base_path, logger=nil)
      @client = SlackClient.new(api_key, channel)
      @channel = channel
      @base_path = base_path
      self.logger = logger
    end

    def export
      raise StandardError("Directory #{base_path} does not exist") unless Dir.exist?(base_path)
      log "Exporting #{channel} to folder #{base_path}"

      # CHANNELS
      channels = client.get_channels.select {|c| c["name"] == channel}
      log "Exporting #{channels.count} channels"
      File.open(channels_path, "w") {|f| f.write(channels.to_json)}

      # MESSAGES
      messages = client.get_messages
      log "Exporting #{messages.count} messages"
      Dir.mkdir(messages_base_path) unless Dir.exist?(messages_base_path)
      File.open(messages_path, "w") do |file|
        file.write(messages.to_json)
      end

      # USERS
      users = client.get_users
      log "Exporting #{users.count} users"
      users = users.select do |u|
        messages.any? {|m| m["user"] == u["id"]}
      end
      File.open(users_path, "w") {|f| f.write(users.to_json)}

      # BUNDLE TO ZIP
      log "Bundling export file to #{export_path}"
      Zip::File.open(export_path, Zip::File::CREATE) do |zip|
        zip.add(users_filename, users_path)
        zip.add(channels_filename, channels_path)
        zip.add(messages_sub_path, messages_path)
      end
    end

    def export_path
      File.join(base_path, "#{channel}.zip")
    end

    private

    def users_filename
      "users.json"
    end

    def users_path
      File.join(base_path, users_filename)
    end

    def channels_filename
      "channels.json"
    end

    def channels_path
      File.join(base_path, channels_filename)
    end

    def messages_filename
      "messages.json"
    end

    def messages_base_path
      File.join(base_path, channel)
    end

    def messages_sub_path
      File.join(channel, messages_filename)
    end

    def messages_path
      File.join(base_path, messages_sub_path)
    end

    def log(message)
      logger.call message if logger
    end

  end
end
