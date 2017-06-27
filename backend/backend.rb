require "sinatra"
require "sinatra/namespace"
require 'json'

namespace "/api" do
	namespace "/v1" do
			post "/login" do
				content_type :json
				payload = JSON.parse(request.body.read)
				res = {}

				if payload.key? "username"
					res[:username] = payload["username"]
				else
					status = "username missing"
				end

				if payload.key? "password"
					res[:password] = payload["password"]
				else
					status = "password missing"
				end

				res[:status] = status

				res.to_json
			end
	end
end

get "/" do
	send_file "public/index.html"
end
