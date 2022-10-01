package cn.nilnullnaught.SpringMVCTest.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

// 定义配置类加载Controller对应的bean
@Configuration
@ComponentScan("cn.nilnullnaught.SpringMVCTest.controller")
public class SpringMvcConfig {
}
