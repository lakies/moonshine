FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    ragel && \
    wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.22.0.linux-amd64.tar.gz && \
    rm go1.22.0.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin
ENV GOPATH=/go
ENV PATH=$PATH:$GOPATH/bin

# Set the working directory
WORKDIR /app

# Copy the go.mod and go.sum files
COPY go.mod go.sum ./

# Download all dependencies
RUN go mod download

# Install goyacc
RUN go install golang.org/x/tools/cmd/goyacc@latest

# Copy the current directory contents into the container at /app
# ADD . /app

# Run app.py when the container launches
CMD ["bash"]