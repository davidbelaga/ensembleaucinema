class AlgoliaScrapJob < ApplicationJob
  # queue_as :default

  def perform
    require 'net/http'
    require 'json'
    require 'rubygems'
    require 'algoliasearch'
    require 'objspace'

    Algolia.init(application_id: '0BOKPT0IXQ', api_key: '...')

    index = Algolia::Index.new('LondonFilms')
    index.clear_index
    index.set_settings(
      searchableAttributes: [
        'film_name'
      ],
      customRanking: [
        'desc(popularity)'
      ]
    )

    uri = URI.parse("https://api-gate.movieglu.com/filmsNowShowing/?n=25")
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

    index.add_objects(response)
  end
end
