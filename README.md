# Publicador de Clima

=================
<!--ts-->
* [Sobre](#sobre)
* [Pré Requisitos](#pre-requisitos)
* [Instalação](#instalacao)
* [Como usar](#como-usar)
* [Gems](#gems)
* [Tests](#testes)
<!--ts-->

## Sobre

Publique as informações de clima de determinada região no Twitter. Informações do dia e previsões para os dias posteriores.

## Pré Requisitos

* Ruby >= 3.0.0
* Rails >= 6.0
* Bundler >= 2.2

## Instalação

```bash
# Clone este repositório
$ git clone <https://github.com/>

# Acesse a pasta do projeto
$ cd pasta

# Instale as dependências
$ bundle install

# Execute a aplicação
$ rails s
```

## Como usar

Os endpoints para utilização são:

### "Twettar" uma informação de clima

#### Request

`POST /tweet/clima`

```json
{
    "cidade": "Campinas",
    "pais": "BR",
    "open_weather_map_key": "key_weather_map",
    "twitter_consumer_key": "key_weather_map",
    "twitter_consumer_key_secret": "key_weather_map",
    "twitter_access_token": "key_weather_map",
    "twitter_access_token_secret": "key_weather_map",
}
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
    "tweet": "<temperatura> e <clima> em <cidade> em <data>. Média para os próximos dias: <temperatura> em <data>, ...",
    "date": "timestamp",
    "user": "@user"
}
```

## Gems

* [twitter](https://rubygems.org/gems/twitter/versions/6.2.0)
* [openweathermap](https://rubygems.org/gems/openweathermap/versions/0.2.3)