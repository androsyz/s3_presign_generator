run:
	@echo "🚀 Running S3PresignGenerator"
	mix run -e "S3PresignGenerator.run()"

test:
	@echo "🚀 Running S3PresignGenerator test"
	mix test test/s3_presign_generator_test.exs