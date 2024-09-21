require 'aws-sdk-opensearchservice'
require 'json'
require 'net/http'
require 'uri'

class OpenSearchClient
  def initialize
    Aws.config.update({
      region: 'us-east-1',
      credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"])
    })

    @host = "https://search-drift-tube-unq3q6cobgskwiiszs3k42tv2q.us-east-1.es.amazonaws.com"
    @index_name = 'ja_video_vector_index'
  end

  def search_videos(vector)
    vector = bedrock_embedding
    opposite_vector = vector.map { |x| -x }

    # 検索クエリの作成
    search_body = {
      size: 10,
      _source: ['title'],
      query: {
        knn: {
          vector: {
            vector: vector,
            k: 10
          }
        }
      }
    }

    # 類似ビデオ検索
    # puts "query: #{query}"
    puts "similar videos"
    response = search_index(search_body)
    puts JSON.pretty_generate(response)

    # 非類似ビデオ検索
    search_body[:query][:knn][:vector][:vector] = opposite_vector
    puts "disimilar videos"
    response = search_index(search_body)
    puts JSON.pretty_generate(response)
  end

  def search_index(body)
    uri = URI.parse("https://#{@host}/#{@index_name}/_search")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri, { 'Content-Type': 'application/json' })
    request.body = body.to_json

    response = http.request(request)
    JSON.parse(response.body)
  end
end