# Use an official base image
FROM ubuntu:latest

# Update and install necessary packages
RUN apt-get -y update && apt-get -y install git

# Argument for SSH private key
ARG SSH_PRIVATE_KEY

# Setup SSH (remember to use .dockerignore to prevent your private key from being sent to the Docker daemon)
RUN mkdir /root/.ssh/ && \
    echo "$SSH_PRIVATE_KEY" > /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa && \
    ssh-keyscan github.com > /root/.ssh/known_hosts

# Set the working directory
WORKDIR /usr/src/app

# Copy the script into the container
COPY src/bash.sh ./

# Make sure the script is executable
RUN chmod +x bash.sh

# Execute the script when the container starts
CMD ["./bash.sh"]
