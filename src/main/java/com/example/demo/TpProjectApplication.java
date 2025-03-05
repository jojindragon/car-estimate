package com.example.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan({"data.*", "*.controller", "naver.*"})
@MapperScan({"data.mapper"})
public class TpProjectApplication {

	public static void main(String[] args) {
		SpringApplication.run(TpProjectApplication.class, args);
	}

}
