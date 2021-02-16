class Api::V1::PublishController < ApplicationController

    def index
        info = {
            "endpoint": "POST /api/v1/publish",
            "parametros": ['cidade', 'pais', 'open_weather_map_key', 'twitter_consumer_key', 'twitter_consumer_key_secret', 'twitter_access_token', 'twitter_access_token_secret'],
            "observações": [
                "Todos os campos são obrigatórios.",
                "O campo \`cidade\` deverá ser de uma cidade existente, não sendo necessário adicionar acentuação.",
                "O campo \`pais\` deverá ser um país correspondente a cidade. Para detalhes veja esta [lista](http://bulk.openweathermap.org/sample/city.list.json.gz).",
                "O campo \`open_weather_map_key\` corresponde à chave do OpenWeatherMap. É necessário realizar um cadastro e esta chave é enviada para seu email.",
                "Os campos \`twitter_consumer_key\` e \`twitter_consumer_key_secret\`, identificados como \`API Key\` e \`API Secret Key\` respectivamente, são fornecidos no ato da habilitação da conta do Twitter como desenvolvedor.",
                "Os campos \`twitter_access_token\` e \`twitter_access_token_secret\`, itendificados como \`Access Token\` e \`Access Token secret\` respectivamente, são fornecidos após o cadastro da aplicação no Twitter nas configurações. É necessário criar com permissões de leitura e escrita."
            ]

        }
        render json: info
    end

    def create
        begin
            open_weather_map = Api::V1::OpenWeatherMapController.new(
                params[:open_weather_map_key], 
                params[:cidade], 
                params[:pais]
            )

            weather = open_weather_map.get_weather

            twitter = Api::V1::TwitterController.new(
                params[:twitter_consumer_key],
                params[:twitter_consumer_key_secret],
                params[:twitter_access_token],
                params[:twitter_access_token_secret]
            )

            tweet_status = twitter.tweet(weather)

        rescue OpenWeatherMap::Exceptions::UnknownLocation
            render json: {"error": "Localização inválida. Campos cidade e pais com valores inválidos ou não relacionados."}
        rescue OpenWeatherMap::Exceptions::Unauthorized
            render json: {"error": "Não autorizado. Campo open_weather_map_key com valor inválido."}
        rescue Twitter::Error::Unauthorized
            render json: {"error": "Não autorizado. Campos twitter_access_token, twitter_access_token_secret, twitter_consumer_key ou twitter_consumer_key_secret com valores inválidos."}
        rescue Twitter::Error::BadRequest
            render json: {"error": "Não autorizado. Campos twitter_access_token, twitter_access_token_secret, twitter_consumer_key ou twitter_consumer_key_secret com valores inválidos."}
        else
            render json: {
                "msg": weather,
                "success": "tweet publicado com sucesso.",
                "date": Time.now.strftime("%Y-%m-%d %H:%M:%S")
            }
        end
    end
end
