# config/initializers/aws.rb

# require 'aws-sdk-sts'

# sts_client = Aws::STS::Client.new(
#   region: 'us-east-1'
# )

# assumed_role = sts_client.assume_role(
#   role_arn: 'arn:aws:iam::984877473294:role/nanako-account',
#   role_session_name: 'RailsCrossAccountSession'
# )

# # 一時的なクレデンシャルを取得
# Aws.config.update({
#   region: 'us-east-1',
#   credentials: Aws::Credentials.new(
#     assumed_role.credentials.access_key_id,
#     assumed_role.credentials.secret_access_key,
#     assumed_role.credentials.session_token
#   )
# })
