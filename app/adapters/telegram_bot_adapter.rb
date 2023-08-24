# frozen_string_literal: true

class TelegramBotAdapter < BaseAdapter
  def initialize(args = {})
    @action = args[:action] || :get
    @endpoint = args[:endpoint] || TELEGRAM::END_POINTS::GET_UPDATES
    @params = args[:params] || {}
  end

  def execute
    @response = HTTParty.send(action, endpoint, params)

    {
      code: response.code,
      body: response.parsed_response.deep_symbolize_keys.except(:ok)
    }
  end

  def success?
    response.code.in?(TELEGRAM::CODE::SUCCESS)
  end

  private

  attr_reader :action, :endpoint, :params, :response
end
