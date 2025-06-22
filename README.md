# 🚀 Spring Boot VPS Auto Deploy Script

A fully automated deployment solution for Java Spring Boot applications on a Linux VPS using Bash — no need for GitHub Actions or Jenkins! This script takes care of pulling the latest code, building the project, installing dependencies, and deploying your app either as a system service or as a standalone process.

```
📂 Project Structure

springboot-vps-deploy/
├── deploy.sh               # Main deployment script
├── README.md               # Documentation
└── (your Spring Boot app)  # Your application code and files
```

---

## ✨ Features

- 🔁 Auto-pulls latest changes from GitHub
- ⚙️ Automatically installs Java & Maven if missing
- 🛠️ Builds the Spring Boot project using Maven
- 🚀 Runs the app as a background service (systemd) or in foreground
- 🔄 Optional cron job to auto-check and redeploy every 5 minutes
- 📜 Clean output, logs, and retry safety
- 📡 Access the app via your VPS IP and exposed port

---

## 🧰 Requirements

- A Linux VPS (tested on Ubuntu 20.04/22.04)
- A GitHub-hosted Spring Boot project
- Git installed on your server
- Public IP access and open port (e.g., 8080)

---

## 🚀 Deployment Guide

Follow these steps to deploy your Spring Boot app using the provided script.

### 1. SSH into Your VPS

```bash
ssh your-user@your-vps-ip
```

### 2. Clone Your GitHub Repository

```bash
git clone https://github.com/your-username/springboot-vps-deploy.git
cd springboot-vps-deploy
```

> Replace `your-username` with your GitHub username.

### 3. Make the Script Executable

```bash
chmod +x deploy.sh
```

### 4. Run the Script Manually (First-Time Setup)

```bash
./deploy.sh
```

You’ll be asked to choose:

- Run as a **Linux service** (background process with auto-restart)
- Run in **foreground** (live logs shown in terminal)

---

## 🔁 Set Up Auto-Deploy with Cron (Optional)

Automatically check for code updates and redeploy every 5 minutes:

```bash
crontab -e
```

Add this line at the bottom (update the path to your repo):

```bash
*/5 * * * * /home/ubuntu/springboot-vps-deploy/deploy.sh >> /home/ubuntu/springboot-vps-deploy/deploy.log 2>&1
```

This keeps your app in sync with the latest commits on the `main` branch.

---

## 🔧 Service Management Commands

If you chose to run your app as a **systemd service**, use the following commands:

| Action              | Command                                    |
|---------------------|--------------------------------------------|
| Check status        | `sudo systemctl status springboot-app`     |
| Restart app         | `sudo systemctl restart springboot-app`    |
| Stop app            | `sudo systemctl stop springboot-app`       |
| View logs           | `journalctl -u springboot-app -f`          |

---

## 🌐 Accessing Your App

Once the app is deployed and running, access it at:

```
http://<your-vps-ip>:8080
```

> Make sure your firewall allows traffic on port 8080:

```bash
sudo ufw allow 8080
```

---

## 💻 Example Usage in One Go

```bash
# SSH into server
ssh ubuntu@your-vps-ip

# Clone project
git clone https://github.com/your-username/springboot-vps-deploy.git
cd springboot-vps-deploy

# Make script executable
chmod +x deploy.sh

# Run deployment
./deploy.sh
```

---

## 🧠 Notes

- The script checks for updates using `git fetch` and compares commits.
- If no change is found, it skips rebuild/restart and exits silently.
- JAR file is renamed to `app.jar` after build and used in the service.
- All logs (when running via cron) are appended to `deploy.log`.

---

## 👨‍💻 Author

**Abad Naseer**  
Full-stack Developer | DevOps Engineer  
Fiverr & Upwork Verified Freelancer  
[Connect on LinkedIn](https://linkedin.com/in/your-profile)

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).