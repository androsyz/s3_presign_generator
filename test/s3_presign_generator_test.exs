defmodule S3PresignGeneratorTest do
  use ExUnit.Case

  alias S3PresignGenerator

  @input_path "test_input.csv"
  @output_path "test_output.csv"

  setup do
    File.write!(@input_path, """
    identifier,folder_name,filename
    TEST123,fake-folder,fake-file.txt
    """)

    on_exit(fn ->
      File.rm_rf(@input_path)
      File.rm_rf(@output_path)
    end)

    :ok
  end

  test "generates a presigned URL CSV from valid input" do
    S3PresignGenerator.run(@input_path, @output_path)

    assert File.exists?(@output_path)

    output = File.read!(@output_path)

    assert output =~ "identifier,presigned_url"

    assert output =~ "TEST123,"

    [_header, row] = String.split(output, "\n", trim: true)
    [id, url] = String.split(row, ",", parts: 2)
    assert id == "TEST123"
    assert String.starts_with?(url, "http")
  end
end
