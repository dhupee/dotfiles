# Base image
FROM golang:1.21.5-alpine3.19 AS Builder

# Set the working directory inside the container
WORKDIR /app

# Copy the application source code
COPY . .

# Download and cache Go modules
RUN go mod download

# Build the application
RUN go build -o ./appbin ./main.go

FROM alpine:3.19

# Set the working directory inside the container
WORKDIR /app

# Copy the application binary from the builder image
COPY --from=Builder /app/appbin ./
COPY --from=Builder /app/assets ./assets

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["./appbin"]
