package com.roushan.microservices;

import java.util.LinkedHashMap;
import java.util.Map;

import com.roushan.microservices.services.ProductCompositeIntegration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.actuate.health.CompositeReactiveHealthContributor;
import org.springframework.boot.actuate.health.ReactiveHealthContributor;
import org.springframework.boot.actuate.health.ReactiveHealthIndicator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class HealthCheckConfiguration {

  @Autowired
  ProductCompositeIntegration integration;

  @Bean
  ReactiveHealthContributor coreServices() {

    final Map<String, ReactiveHealthIndicator> registry = new LinkedHashMap<>();

    registry.put("product", () -> integration.getProductHealth());
    registry.put("recommendation", () -> integration.getRecommendationHealth());
    registry.put("review", () -> integration.getReviewHealth());

    return CompositeReactiveHealthContributor.fromMap(registry);
  }
}
