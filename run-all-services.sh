#!/bin/bash

echo "Starting all microservices..."

# Create logs directory if it doesn't exist
mkdir -p logs

# Start each service in background and redirect output
./gradlew :util:build > logs/util.log 2>&1 &
echo "Built util module"

./gradlew :api-service:bootRun > logs/api-service.log 2>&1 &
echo "Started api-service..."

./gradlew :product-service:bootRun > logs/product-service.log 2>&1 &
echo "Started product-service..."

./gradlew :product-composite-service:bootRun > logs/product-composite-service.log 2>&1 &
echo "Started product-composite-service..."

echo "All services started in background. Check logs folder for output."
