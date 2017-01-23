require_relative 'request_parser'

class MessageHandler
  def initialize()
    @request_parser = RequestParser.new()
  end

  def handle(team_id, event_data) 
    user_id = event_data['user']
    channel = event_data['channel']
    user_message = event_data['text']

    returned_command = @request_parser.parse(event_data)
    returned_command.run()

    if returned_command.response?
      respond(returned_command.response, team_id, user_id, channel)
    end
  end

  def respond(bot_answer, team_id, user_id, channel = user_id)
      response = Response.new(team_id, channel)
      response.send(bot_answer)
  end
end
