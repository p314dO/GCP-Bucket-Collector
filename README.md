# GCP Bucket Collector

A lightweight bash utility designed for penetration testing and security assessments to enumerate and analyze Google Cloud Storage bucket contents without downloading files to disk.

## 🎯 Purpose

During security assessments, you often need to quickly identify sensitive information within cloud storage buckets without actually downloading files. This tool allows you to:

- Enumerate objects within a GCP bucket with a specific prefix
- Extract metadata from each object
- Read file contents directly to stdout
- Maintain a low footprint by avoiding file downloads

## 🔧 Requirements

- **Google Cloud SDK** (`gcloud` and `gsutil`)
- **Bash** shell environment
- **Appropriate GCP permissions** to access the target bucket (read/list)

## 📦 Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/gcp-bucket-collector.git
cd gcp-bucket-collector
```

2. Make the script executable:
```bash
chmod +x gcpbucketcollector.sh
```

3. Ensure you have the Google Cloud SDK installed and configured:
```bash
# Install gcloud CLI if not already installed
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

# Authenticate with your GCP account
gcloud auth login
```

## 🚀 Usage

```bash
./gcpbucketcollector.sh <bucket> <prefix> <output_file>
```

### Parameters

- `<bucket>`: The target GCP bucket name (without gs:// prefix)
- `<prefix>`: The path prefix within the bucket to enumerate
- `<output_file>`: Output file where results will be saved

### Examples

```bash
# Collect all objects with prefix "documents" from a company bucket (gs://company-data-bucket/documents)
./gcpbucketcollector.sh company-data-bucket documents scan_results.txt

# Enumerate configuration files from a web application bucket
./gcpbucketcollector.sh webapp-configs config config_analysis.txt

# Scan user data directory from a backup bucket
./gcpbucketcollector.sh backup-storage users/data user_data_report.txt
```

## 📋 Output Format

The tool generates a structured output containing:

```
===== Processing: gs://target-bucket/path/file.txt =====
-- Metadata --
[Object metadata including size, creation date, content type, etc.]

-- Content --
[Actual file content]

===== Finished: gs://target-bucket/path/file.txt =====
```

## ⚙️ Configuration

The script now accepts the bucket name as a parameter, making it flexible for different targets.

## 🔒 Security Considerations

- **Authorization**: Ensure you have explicit permission to access the target bucket
- **Logging**: Be aware that bucket access may be logged by the target organization
- **Sensitive Data**: Handle any discovered sensitive information according to your organization's data handling policies
- **Rate Limiting**: The script processes files sequentially to avoid overwhelming the target

## ⚠️ Ethical Usage

This tool is intended for:
- ✅ Authorized penetration testing
- ✅ Security assessments with proper scope
- ✅ Bug bounty programs (where cloud storage is in scope)
- ✅ Internal security audits

**NOT for:**
- ❌ Unauthorized access to cloud resources
- ❌ Data theft or malicious activities
- ❌ Violation of terms of service

## 🛠️ Troubleshooting

### Common Issues

**Permission Denied**
```bash
# Ensure you're authenticated
gcloud auth list
gcloud auth application-default login
```

**Bucket Not Found**
- Verify the bucket name and your access permissions
- Check if the bucket exists: `gsutil ls gs://bucket-name`

**Large Files Timing Out**
- The script reads entire file contents, which may be slow for large files
- Consider adding timeout controls for production use

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚡ Roadmap

- [ ] Add support for multiple bucket targets
- [ ] Implement file type filtering
- [ ] Add progress indicators for large enumerations
- [ ] Support for output formats (JSON, CSV)
- [ ] Integration with popular pentesting frameworks

## 📞 Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/p314dO/gcp-bucket-collector/issues) page
2. Create a new issue with detailed information about your problem
3. Include your environment details (OS, gcloud version, etc.)

---

⭐ **Star this repository if you find it useful!**

---

**Disclaimer**: This tool is for educational and authorized testing purposes only. Users are responsible for complying with applicable laws and obtaining proper authorization before use.
