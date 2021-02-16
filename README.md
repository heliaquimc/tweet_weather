# Tweet Weather

<!--ts-->
* [Sobre](#sobre)
* [Pré Requisitos](#pre-requisitos)
* [Instalação](#instalacao)
* [Como usar](#como-usar)
* [Gems](#gems)
<!--ts-->

## Sobre

Publique as informações de clima de determinada região no Twitter utilizando as API's do OpenWeatherMap e Twitter. Informações do dia e previsões para os dias posteriores.

Este projeto faz parte do desafio proposto pela empresa [Caiena](https://caiena.net/).

## Pré Requisitos

* Ruby >= 3.0.0
* Rails >= 6.0
* Bundler >= 2.2

## Instalação

```bash
# Clone este repositório
$ git clone git@github.com:heliaquimc/tweet_weather.git

# Acesse a pasta do projeto
$ cd tweet_weather

# Instale as dependências
$ bundle install

# Execute a aplicação
$ rails s
```

## Como usar

Os endpoints para utilização são:

### "Twettar" uma informação de clima

#### Request

`POST /api/v1/publish`

```json
[
    "cidade",
    "pais",
    "open_weather_map_key",
    "twitter_consumer_key",
    "twitter_consumer_key_secret",
    "twitter_access_token",
    "twitter_access_token_secret",
]
```

Observações:

* Todos os campos são obrigatórios.
* O campo `cidade` deverá ser de uma cidade existente, não sendo necessário adicionar acentuação.
* O campo `pais` deverá ser um país correspondente a cidade. Para detalhes veja esta [lista](http://bulk.openweathermap.org/sample/city.list.json.gz).
* O campo `open_weather_map_key` corresponde à chave do OpenWeatherMap. É necessário realizar um cadastro e esta chave é enviada para seu email.
* Os campos `twitter_consumer_key` e `twitter_consumer_key_secret`, identificados como `API Key` e `API Secret Key` respectivamente, são fornecidos no ato da habilitação da conta do Twitter como desenvolvedor.
* Os campos `twitter_access_token` e `twitter_access_token_secret`, itendificados como `Access Token` e `Access Token secret` respectivamente, são fornecidos após o cadastro da aplicação no Twitter nas configurações. É necessário criar com permissões de leitura e escrita.

#### Response

`201` - Tweet criado

```json
{
    "msg": "<temperatura> e <clima> em <cidade> em <data>. Média para os próximos dias: <temperatura> em <data>, ...",
    "success": "tweet publicado com sucesso.",
    "date": "YYYY-MM-DD HH:MM:SS",
}
```

`400` - Bad Request

```json
{
    "error": "Localização inválida. Campos cidade e pais com valores inválidos ou não relacionados."
}
```

ou

```json
{
    "error": "Não autorizado. Campos twitter_access_token, twitter_access_token_secret, twitter_consumer_key ou twitter_consumer_key_secret com valores inválidos."
}
```

`403` - Forbidden

```json
{
    "error": "Não autorizado. Campo open_weather_map_key com valor inválido."
}
```

ou

```json
{
    "error": "Não autorizado. Campos twitter_access_token, twitter_access_token_secret, twitter_consumer_key ou twitter_consumer_key_secret com valores inválidos."
}
```

## Gems

* [twitter](https://rubygems.org/gems/twitter/versions/6.2.0)
* [openweathermap](https://rubygems.org/gems/openweathermap/versions/0.2.3)
* rspec-rails
* ffaker