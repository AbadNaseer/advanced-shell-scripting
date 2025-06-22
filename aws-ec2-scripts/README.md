# 🚀 AWS EC2 CLI Automation – Bash Script (No Terraform)

This project automates the full lifecycle of an EC2 instance using **Bash scripts and AWS CLI**, with no need for Terraform or GitHub Actions. Easily create, manage, and destroy AWS EC2 instances straight from your terminal.

---

## 📂 Folder Structure

```
aws-ec2-cli-scripts/
├── aws-ec2-deploy.sh       # Bash script to manage EC2
├── .instance_id            # Auto-created file with EC2 instance ID
├── README.md               # Documentation (this file)
```

---

## 🧰 Requirements

| Tool         | Purpose                            |
|--------------|-------------------------------------|
| AWS CLI      | To interact with AWS from terminal  |
| Bash         | To run the script                   |
| IAM Access   | AWS Access/Secret Key with EC2 rights |
| Existing AWS resources | AMI, Key Pair, Security Group |

---

## 🔧 Setup Instructions

### 1. 🔌 Install AWS CLI

```bash
sudo apt update
sudo apt install awscli -y
```

---

### 2. ⚙️ Configure AWS CLI

```bash
aws configure
```

Enter the following:
- AWS Access Key ID  
- AWS Secret Access Key  
- Default region (e.g., `us-east-1`)  
- Output format (e.g., `json`)

Credentials will be stored in:
```
~/.aws/credentials
```

---

### 3. 📦 Clone the Repository

```bash
git clone https://github.com/your-username/aws-ec2-cli-scripts.git
cd aws-ec2-cli-scripts
```

---

### 4. ✅ Make Script Executable

```bash
chmod +x aws-ec2-deploy.sh
```

---

### 5. 🛠 Configure Script Values

Open `aws-ec2-deploy.sh` and set:
```bash
AMI_ID="ami-0abcdef1234567890"      # Your AMI ID
KEY_NAME="your-key"                 # Your Key Pair Name
SECURITY_GROUP="sg-12345678"        # Your Security Group ID
REGION="us-east-1"                  # Your preferred AWS region
```

---

## 🚀 Available Commands

```bash
./aws-ec2-deploy.sh create       # Create and tag an EC2 instance
./aws-ec2-deploy.sh status       # Show current instance state
./aws-ec2-deploy.sh ip           # Show public IP of instance
./aws-ec2-deploy.sh stop         # Stop instance
./aws-ec2-deploy.sh start        # Start instance
./aws-ec2-deploy.sh terminate    # Terminate and delete instance
```

---

## 🖥️ What Happens Internally

| Step                | Details                                                                 |
|---------------------|-------------------------------------------------------------------------|
| `aws configure`      | Connects CLI to your AWS account                                        |
| `run-instances`      | Launches a t2.micro EC2 instance                                        |
| `sleep`              | Waits 10-15 seconds to allow AWS to initialize resources                |
| `create-tags`        | Tags instance with `Name=cli-ec2-instance`                              |
| `describe-instances` | Gets IP and state                                                       |
| `start/stop`         | Controls instance power state                                           |
| `terminate`          | Terminates instance and deletes the `.instance_id` file                |

---

## 📜 Sample Output

```bash
$ ./aws-ec2-deploy.sh create

🚀 Launching EC2 instance...
⏳ Waiting for instance to initialize...
🏷️ Tagging instance as 'cli-ec2-instance'
✅ Instance created: i-0abc123def456gh78
```

```bash
$ ./aws-ec2-deploy.sh ip

🌍 Fetching public IP...
54.213.22.101
```

---

## 📌 Notes

- The instance ID is stored in `.instance_id`
- If this file is missing, status/stop/start commands will fail
- Use `terminate` to destroy the instance and clean up local files
- This is ideal for demos, testing, DevOps practice, and automation experiments

---

## 👨‍💻 Author

**Abad Naseer**  
Full-stack Developer | DevOps Engineer  
Fiverr & Upwork Verified  
[LinkedIn](https://linkedin.com/in/AbadNaseer)  

---

## 📜 License

This project is licensed under the [MIT License](LICENSE)
