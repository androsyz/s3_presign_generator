defmodule S3PresignGenerator do
  alias ExAws.S3
  alias Helper.Config, as: AppConfig
  alias Helper.Validator

  @doc """
  Reads CSV with headers: identifier, folder_name, filename
  and produces a list of maps with identifier and presigned_url.
  """
  def run(input_path \\ AppConfig.file_input(), output_path \\ AppConfig.file_output()) do
    IO.puts("⏳ Generating presigned URLs from #{input_path}")

    input_path
    |> File.stream!()
    |> CSV.decode!(headers: true)
    |> Enum.map(&Validator.remove_bom_from_keys/1)
    |> Enum.map(&generate_url/1)
    |> write_output(output_path)
  end

  defp generate_url(row) do
    identifier_key = AppConfig.identifier_header()
    identifier = Map.get(row, identifier_key)

    folder = Map.get(row, "folder_name")
    file = Map.get(row, "filename")
    base = AppConfig.aws_base_folder()
    bucket = AppConfig.aws_bucket()
    expires = AppConfig.aws_expires()

    if is_nil(folder) or folder == "" or is_nil(file) or file == "" do
      IO.puts("⚠️ Skipping presigned URL for #{identifier}: missing folder or filename")
      %{identifier_key => identifier, "presigned_url" => ""}
    else
      key =
        [base, folder, file]
        |> Enum.reject(&(&1 in [nil, ""]))
        |> Path.join()

      case S3.presigned_url(ExAws.Config.new(:s3), :get, bucket, key, expires_in: expires) do
        {:ok, url} ->
          %{identifier_key => identifier, "presigned_url" => url}

        {:error, reason} ->
          IO.puts("❌ Failed to generate presigned URL for #{identifier}: #{inspect(reason)}")
          %{identifier_key => identifier, "presigned_url" => ""}
      end
    end
  end

  defp write_output(data, path) do
    identifier_key = AppConfig.identifier_header()

    File.open!(path, [:write], fn file ->
      IO.write(file, "#{identifier_key},presigned_url\n")

      Enum.each(data, fn row ->
        identifier = Map.fetch!(row, identifier_key)
        url = Map.fetch!(row, "presigned_url")
        IO.write(file, "#{identifier},#{url}\n")
      end)
    end)

    IO.puts("✅ Output CSV written to #{path}")
  end
end
