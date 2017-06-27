require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/cross_origin'
require 'json'
require 'jwt'

namespace '/api' do
    namespace '/v1' do
        post '/login' do
            content_type :json
            cross_origin :allow_origin => '*'
            payload = JSON.parse(request.body.read)

            puts 'Received ' + payload.to_s

            hmac_secret = 'secret'

            if payload.key?('username') && payload.key?('password')
                token = JWT.encode payload, hmac_secret, 'HS256'
            end

            res = { 'jwt' => token }

            res.to_json
        end

        options '*' do
            response.headers['Allow'] = 'HEAD,GET,PUT,POST,DELETE,OPTIONS'

            response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'

            200
        end
    end
end

get '/' do
    send_file 'public/index.html'
end
