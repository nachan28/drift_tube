class EmbeddingsController < ApplicationController
  def create
    br_client = BedrockClient.new
    vector = br_client.bedrock_embedding(params[:text])
    opposite_vector = br_client.opposite_vector(vector)

    os_client = OpenSearchClient.new
    os_client.search_videos(opposite_vector)
  end
end
