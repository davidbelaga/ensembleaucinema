require 'net/http'
require 'uri'
require 'json'
require 'rubygems'

uris = {}
uris["Films Showing"] = URI.parse("https://api-gate.movieglu.com/filmsNowShowing/?n=25")
uris["Cinemas Nearby"] = URI.parse("https://api-gate.movieglu.com/cinemasNearby/?n=25")
uris["Showtimes"] = URI.parse("https://api-gate.movieglu.com/cinemaShowTimes/?cinema_id=8893&date=2018-10-12&sort=popularity")
jsonfiles = ["db/movies.json", "db/cinemas.json", "db/showtimes.json"]

for n in 0..2 do
  uri = uris.values[n]
  request = Net::HTTP::Get.new(uri)
  request["api-version"] = "v102"
  request["authorization"] = "Basic SEhKSDo0eWFYeTVFaDdJRHg="
  request["x-api-key"] = "ikjkxyR3ol2zAb3wo9TFx9n9a352eo2N3r0nnp9A"
  request["client"] = "HHJH"
  request["geolocation"] = "51.509865;-0.118092"

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  File.open(jsonfiles[n],"w") do |f|
    f.truncate(0)
    f.write(JSON.pretty_generate(response.body))
  end
  puts ">>"
  puts "voici la liste des #{uris.keys[n]} "
  puts ">>"
  puts response.body
end
