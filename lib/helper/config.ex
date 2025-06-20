defmodule Helper.Config do
  @app :s3_presign_generator

  def aws_bucket, do: Application.get_env(@app, :aws_bucket)
  def aws_expires, do: Application.get_env(@app, :aws_expires, 3600)
  def aws_base_folder, do: Application.get_env(@app, :aws_base_folder, "private")
  def file_input, do: Application.get_env(@app, :file_input, "input.csv")
  def file_output, do: Application.get_env(@app, :file_output, "output.csv")
  def identifier_header, do: Application.get_env(@app, :file_identifier_header, "identifier")
end
