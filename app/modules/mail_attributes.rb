# frozen_string_literal: true

module MailAttributes
  def welcome(args = {})
    {
      email_type: :welcome,
      sender: { email: args[:sender] },
      reply_to: { email: args[:reply_to] },
      template_id: args[:template_id],
      dynamic_template_data: args[:dynamic_template_data],
      to: args[:to]
    }.as_json
  end
end
