#!/bin/bash

# ------------------------------
# Spring Boot App Deployment Script
# Written by Abad Naseer ✨
# ------------------------------

REPO_URL="https://github.com/your-username/springboot-vps-deploy.git"  # kindly Replace this
APP_DIR="/home/ubuntu/springboot-vps-deploy"
JAR_NAME="app.jar"
SERVICE_NAME="springboot-app"
BRANCH="main"

install_dependencies() {
    echo "🔧 Checking Java and Maven..."

    if ! command -v java &> /dev/null; then
        echo "Installing Java..."
        sudo apt update && sudo apt install default-jdk -y
    fi

    if ! command -v mvn &> /dev/null; then
        echo "Installing Maven..."
        sudo apt install maven -y
    fi
}

update_repo() {
    if [ ! -d "$APP_DIR" ]; then
        echo "📥 Cloning project..."
        git clone -b $BRANCH "$REPO_URL" "$APP_DIR"
        return 0
    else
        cd "$APP_DIR" || exit
        echo "🔄 Fetching changes..."
        git fetch origin $BRANCH
        LOCAL_HASH=$(git rev-parse HEAD)
        REMOTE_HASH=$(git rev-parse origin/$BRANCH)

        if [ "$LOCAL_HASH" != "$REMOTE_HASH" ]; then
            echo "🚨 Changes detected. Pulling updates..."
            git reset --hard origin/$BRANCH
            return 0
        else
            echo "✅ App is up-to-date."
            return 1
        fi
    fi
}

build_app() {
    echo "⚙️ Building application..."
    cd "$APP_DIR" || exit
    mvn clean package -DskipTests
    cp target/*.jar "$JAR_NAME"
}

run_as_service() {
    echo "🔧 Setting up systemd service..."

    sudo tee /etc/systemd/system/$SERVICE_NAME.service > /dev/null <<EOF
[Unit]
Description=Spring Boot App
After=network.target

[Service]
User=ubuntu
WorkingDirectory=$APP_DIR
ExecStart=/usr/bin/java -jar $APP_DIR/$JAR_NAME
SuccessExitStatus=143
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

    sudo systemctl daemon-reexec
    sudo systemctl enable $SERVICE_NAME
    sudo systemctl restart $SERVICE_NAME

    echo "✅ App is running as a service: $SERVICE_NAME"
}

run_foreground() {
    echo "🚀 Running app in foreground..."
    cd "$APP_DIR" || exit
    java -jar "$JAR_NAME"
}

# MAIN EXECUTION
install_dependencies
update_repo
UPDATED=$?

if [ "$UPDATED" -eq 0 ]; then
    build_app

    echo ""
    echo "❓ Choose run mode:"
    echo "1) Run as systemd service"
    echo "2) Run in foreground"
    read -rp "Enter your choice [1/2]: " choice

    if [ "$choice" == "1" ]; then
        run_as_service
    else
        run_foreground
    fi
fi
