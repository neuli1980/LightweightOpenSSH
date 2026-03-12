# Use a lightweight base image
FROM alpine:3.23

# Install necessary packages: OpenSSH server and Git
RUN apk update && apk add \
    openssh-server \
    git

# Create SSH directory and set root password
RUN mkdir /var/run/sshd && echo 'root:password' | chpasswd

# Allow root login with password and disable strict host key checking
RUN sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config

# Expose the SSH port
EXPOSE 22

# Start the SSH server
CMD ["/usr/sbin/sshd", "-D"]
