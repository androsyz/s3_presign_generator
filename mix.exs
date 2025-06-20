defmodule S3PresignGenerator.MixProject do
  use Mix.Project

  def project do
    [
      app: :s3_presign_generator,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_aws, "~> 2.4"},
      {:ex_aws_s3, "~> 2.3"},
      {:sweet_xml, "~> 0.7"},
      {:hackney, "~> 1.17"},
      {:csv, "~> 3.0"},
      {:dotenvy, "~> 0.8.0"}
    ]
  end
end
