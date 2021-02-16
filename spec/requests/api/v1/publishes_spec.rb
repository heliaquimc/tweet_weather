require 'rails_helper'

RSpec.describe "Publish", type: :request do
  describe "GET /api/v1/publish" do
    let(:name){"publish"}

    context "when access GET method" do
      it "receive json with some informations about post" do
        get '/api/v1/publish'
        expect(response).to have_http_status(200)
      end
    end

    context "when access POST method" do
      access_params = {}
      access_params[:open_weather_map_key] = ENV['OPEN_WEATHER_MAP_TOKEN']
      access_params[:cidade] = 'Campinas'
      access_params[:pais] = 'BR'
      access_params[:twitter_consumer_key] = ENV['TWITTER_CONSUMER_KEY']
      access_params[:twitter_consumer_key_secret] = ENV['TWITTER_CONSUMER_KEY_SECRET']
      access_params[:twitter_access_token] = ENV['TWITTER_ACCESS_TOKEN']
      access_params[:twitter_access_token_secret] = ENV['TWITTER_ACCESS_TOKEN_SECRET']
      
      context "success" do
        it "returns 201" do
          post '/api/v1/publish', params: access_params
          expect(response).to have_http_status(201)
        end
  
        it "returns json with msg, success and date" do
          post '/api/v1/publish', params: access_params
  
          json_response = JSON.parse({"msg": "", "success": "", "date": ""}.keys)
          expect(response.body).to match(json_response)
        end
      end
      
      context "error" do
        context "when returns 400" do
          it "refers to open_weather_map" do
            access_params[:cidade] = ''
            access_params[:pais] = ''
            post '/api/v1/publish', params: access_params
            expect(response).to have_http_status(400)
          end
  
          it "refers to twitter" do
            access_params[:twitter_consumer_key] = ''
            access_params[:twitter_consumer_key_secret] = ''
            access_params[:twitter_access_token] = ''
            access_params[:twitter_access_token_secret] = ''
  
            post '/api/v1/publish', params: access_params
            expect(response).to have_http_status(400)
          end
  
        end
  
        context "when returns 403" do
          it "refers to open_weather_map" do
            access_params[:open_weather_map_key] = ''
  
            post '/api/v1/publish', params: access_params
            expect(response).to have_http_status(403)
          end
  
          it "refers to twitter" do
            access_params[:twitter_consumer_key] = ''
            access_params[:twitter_consumer_key_secret] = ''
            access_params[:twitter_access_token] = ''
            access_params[:twitter_access_token_secret] = ''
  
            post '/api/v1/publish', params: access_params
            expect(response).to have_http_status(403)
          end
        end
      end
    end
  end
end
