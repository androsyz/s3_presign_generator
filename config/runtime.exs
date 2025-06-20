import Config
import Dotenvy

Dotenvy.source!(Path.expand("../.env", __DIR__))

config :ex_aws,
  access_key_id: env!("AWS_ACCESS_KEY_ID"),
  secret_access_key: env!("AWS_SECRET_ACCESS_KEY"),
  region: env!("AWS_REGION", :string, "ap-southeast-1")

config :s3_presign_generator,
  aws_bucket: env!("AWS_BUCKET"),
  aws_expires: env!("AWS_EXPIRES", :integer, 3600),
  aws_base_folder: env!("AWS_BASE_FOLDER", :string, "private"),
  file_input: env!("FILE_INPUT", :string, "input.csv"),
  file_output: env!("FILE_OUTPUT", :string, "output.csv"),
  file_identifier_header: env!("FILE_IDENTIFIER_HEADER", :string, "identifier")
