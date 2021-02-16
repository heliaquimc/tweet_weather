requite 'twitter'

class Api::V1::TwitterController < ApplicationController
    def initialize(consumer_key, consumer_secret, access_token, access_token_secret)
        @client = Twitter::REST::Client.new do |config|
            config.consumer_key        = consumer_key
            config.consumer_secret     = consumer_secret
            config.access_token        = access_token
            config.access_token_secret = access_token_secret
        end
    end

    def tweet(text)
        begin
            @client.update(text)
        rescue Twitter::Error::Unauthorized
            {"error": "Não autorizado. Campo twitter_access_token ou twitter_access_token_secret com valor inválido."}
        rescue Twitter::Error::BadRequest
            {"error": "Não autorizado. Campo twitter_consumer_key ou twitter_consumer_key_secret com valor inválido."}
        else
            {"success": "Tweet publicado com sucesso."}
        end
    end
end
