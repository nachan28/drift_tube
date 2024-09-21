class BedrockClient
  def initialize
    Aws.config.update({
      region: 'us-east-1',
      credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"])
    })
  end

  def bedrock_embedding(text)
    data = {
       "texts": [text],
       "input_type": "search_document"
    }

    body = data.to_json

    response = bedrock_client.invoke_model({
      accept: "*/*",
      content_type: "application/json",
      body: body,
      model_id: "cohere.embed-multilingual-v3",
    })

    vector = response.body.read
    vector = JSON.parse(vector)["embeddings"][0]
  end

  def bedrock_client
    credentials = Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"])
    client = Aws::BedrockRuntime::Client.new(region: 'us-east-1', credentials: credentials)
  end

  def opposite_vector(vector)
    vector.map { |x| -x }
  end
end