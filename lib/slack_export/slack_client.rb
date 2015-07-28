require "rest-client"

module SlackExport
  class SlackClient

    BASE_URL = "https://slack.com/api/"
    LIST_USERS = "users.list"
    LIST_CHANNELS = "groups.list"
    LIST_MESSAGES = "groups.history"
    CHANNEL_INFO = "groups.info"

    attr_accessor :token, :channel

    def initialize(api_key, channel_name)
      self.token = api_key
      self.channel = get_channel_id(channel_name)
    end

    def get_users
      response = post_form(LIST_USERS)
      response["members"]
    end

    def get_channels
      response = post_form(LIST_CHANNELS)
      response["groups"]
    end

    def get_messages()
      responses = []
      latest = latest.to_i #pages backward, so keep track of most recent message pulled
      oldest = oldest.to_i
      loop do
        responses << post_form(LIST_MESSAGES, { channel: channel, latest: latest, oldest: oldest, count: 1000})
        latest = responses.last["messages"].last["ts"]
        break unless responses.last["has_more"]
      end

      responses.map {|r| r["messages"]}.flatten
    end

    private

    def get_channel_id(channel_name)
      get_channels.select {|g| g["name"] == channel_name}.first["id"]
    end

    def post_form(action, form_values={})
      response = RestClient::Request.execute(
        url: "#{BASE_URL}#{action}",
        method: :post,
        payload: form_values.merge(token: self.token)
      )

      JSON.parse(response)
    end

  end
end