# S3 Presign Generator

Generate AWS S3 pre-signed URLs from a CSV file input.

This tool reads a CSV file containing folder and filename columns, generates pre-signed S3 URLs for each file, and writes the result into an output CSV. It's useful for temporary access to private S3 files without exposing AWS credentials.

---

## ✨ Features

- 🔐 Uses AWS pre-signed URLs with customizable expiration.
- 📂 Reads CSV with headers like `identifier`, `folder_name`, `filename`.
- 📄 Writes output CSV with columns: `identifier,presigned_url`.
- ⚙️ All configurations are via `.env` or system environment variables.

---

## 🚀 Getting Started
1. **Install Dependencies**
```
  mix deps.get
```

2. **Set Environment Variables**

Create a `.env` file by copying the provided example:
```
  cp .env.example .env
```

Then, edit `.env` and set the required values:
```
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_REGION=ap-southeast-1
AWS_BUCKET=your_bucket_name
AWS_EXPIRES=3600
AWS_BASE_FOLDER=private

FILE_INPUT=input.csv
FILE_OUTPUT=output.csv
FILE_IDENTIFIER_HEADER=identifier
```

3. **Run App**
You can run the tool using the provided Makefile:
```
  make run
```

## 📂 Input and Output CSV
The CSV file should include the following headers:
```
  user_id,folder_name,filename
  aksjdh312gj,folder1,document.pdf
```

An output CSV file will be generated (default: output.csv) with columns like:
```
  user_id,presigned_url
  aksjdh312gj,https://s3.ap-southeast-1.amazonaws.com/your_bucket/private/...
```







