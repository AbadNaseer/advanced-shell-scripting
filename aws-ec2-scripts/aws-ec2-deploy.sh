
---

## 🖥️ `aws-ec2-deploy.sh`

```bash
#!/bin/bash

# ----------------------------
# AWS EC2 CLI Automation Script
# Author: Abad Naseer ✨
# ----------------------------

# 🔧 Configuration
AMI_ID="ami-0abcdef1234567890"  # Replace with your AMI ID
INSTANCE_TYPE="t2.micro"
KEY_NAME="your-key"
SECURITY_GROUP="sg-12345678"
REGION="us-east-1"
INSTANCE_NAME="cli-ec2-instance"
INSTANCE_FILE=".instance_id"

# 🛠 Create EC2 Instance
create_instance() {
    echo "🚀 Launching EC2 instance..."

    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id $AMI_ID \
        --instance-type $INSTANCE_TYPE \
        --key-name $KEY_NAME \
        --security-group-ids $SECURITY_GROUP \
        --region $REGION \
        --query "Instances[0].InstanceId" \
        --output text)

    echo "$INSTANCE_ID" > $INSTANCE_FILE

    echo "⏳ Waiting for instance to initialize..."
    sleep 10

    echo "🏷️ Tagging instance as '$INSTANCE_NAME'"
    aws ec2 create-tags \
        --resources $INSTANCE_ID \
        --tags Key=Name,Value="$INSTANCE_NAME" \
        --region $REGION

    echo "✅ Instance created: $INSTANCE_ID"
}

# 🔍 Get Instance Status
instance_status() {
    check_instance_file
    echo "📦 Getting instance status..."
    aws ec2 describe-instances \
        --instance-ids $(cat $INSTANCE_FILE) \
        --region $REGION \
        --query "Reservations[0].Instances[0].State.Name" \
        --output text
}

# 🌐 Get Public IP
get_instance_ip() {
    check_instance_file
    echo "🌍 Fetching public IP..."
    aws ec2 describe-instances \
        --instance-ids $(cat $INSTANCE_FILE) \
        --region $REGION \
        --query "Reservations[0].Instances[0].PublicIpAddress" \
        --output text
}

# 🛑 Stop EC2
stop_instance() {
    check_instance_file
    echo "🛑 Stopping instance..."
    aws ec2 stop-instances \
        --instance-ids $(cat $INSTANCE_FILE) \
        --region $REGION
}

# ▶️ Start EC2
start_instance() {
    check_instance_file
    echo "▶️ Starting instance..."
    aws ec2 start-instances \
        --instance-ids $(cat $INSTANCE_FILE) \
        --region $REGION

    echo "⏳ Waiting 15 seconds..."
    sleep 15
}

# 💣 Terminate EC2
terminate_instance() {
    check_instance_file
    echo "💣 Terminating instance..."
    aws ec2 terminate-instances \
        --instance-ids $(cat $INSTANCE_FILE) \
        --region $REGION

    rm -f $INSTANCE_FILE
    echo "✅ Instance terminated and cleaned up."
}

# 🧪 Check Instance File
check_instance_file() {
    if [ ! -f "$INSTANCE_FILE" ]; then
        echo "❌ Instance ID not found. Please run ./aws-ec2-deploy.sh create first."
        exit 1
    fi
}

# 🚦 Main Control
case "$1" in
    create) create_instance ;;
    status) instance_status ;;
    ip) get_instance_ip ;;
    stop) stop_instance ;;
    start) start_instance ;;
    terminate) terminate_instance ;;
    *)
        echo "Usage: $0 {create|status|ip|stop|start|terminate}"
        ;;
esac
