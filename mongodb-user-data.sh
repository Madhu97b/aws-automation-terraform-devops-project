
#!/bin/bash

set -e

# Update the operating system
dnf update -y

# Configure the official MongoDB 8.0 repository
cat > /etc/yum.repos.d/mongodb-org-8.0.repo <<'EOF'
[mongodb-org-8.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2023/mongodb-org/8.0/$basearch
gpgcheck=1
enabled=1
gpgkey=https://pgp.mongodb.com/server-8.0.asc
EOF

# Install MongoDB and XFS utilities
dnf install -y mongodb-org xfsprogs



# Wait for the additional EBS volume to become available
DATA_DEVICE=""

for attempt in {1..30}; do
    DATA_DEVICE=$(lsblk -b -dn -o NAME,SIZE,TYPE | \
        awk '$2 >= 9*1024*1024*1024 && $3 == "disk" {
            print "/dev/" $1
        }')

    if [ -n "$DATA_DEVICE" ]; then
        break
    fi

    echo "Waiting for MongoDB EBS volume..."
    sleep 10
done

if [ -z "$DATA_DEVICE" ]; then
    echo "ERROR: MongoDB EBS volume not found"
    exit 1
fi

echo "Found MongoDB EBS volume: $DATA_DEVICE"

# Create an XFS filesystem only if the volume is blank
if ! blkid "$DATA_DEVICE"; then
    mkfs.xfs "$DATA_DEVICE"
fi

# Create the MongoDB data directory
mkdir -p /data/mongodb

# Get the filesystem UUID
DATA_UUID=$(blkid -s UUID -o value "$DATA_DEVICE")

# Add persistent mount configuration if not already present
if ! grep -q "UUID=$DATA_UUID" /etc/fstab; then
    echo "UUID=$DATA_UUID /data/mongodb xfs defaults,nofail 0 2" >> /etc/fstab
fi

# Mount the volume
mount /data/mongodb

# Verify the mount
df -h /data/mongodb



# Give MongoDB ownership of its data directory
chown -R mongod:mongod /data/mongodb

# Allow MongoDB to listen on network interfaces
sed -i '/^  bindIp:/d' /etc/mongod.conf

sed -i '/^net:/a\  bindIpAll: true' /etc/mongod.conf

# Configure MongoDB to store database files on EBS
sed -i 's|^  dbPath:.*|  dbPath: /data/mongodb|' /etc/mongod.conf

# Enable and start MongoDB
systemctl daemon-reload
systemctl enable mongod
systemctl start mongod

# Verify MongoDB service
systemctl status mongod --no-pager

