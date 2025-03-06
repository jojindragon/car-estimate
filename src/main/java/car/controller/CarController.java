package car.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import data.service.CarService;
import data.service.CarphotoService;
import lombok.RequiredArgsConstructor;
import naver.storage.NcpObjectStorageService;

@Controller
@RequestMapping("/car")
@RequiredArgsConstructor
public class CarController {
	final CarService carService;
	final CarphotoService carphotoService;
	final NcpObjectStorageService storageService;
	
	private String bucketName = "bucket-mini-139";
	
	// 사진 작업 및 차량 작업 동시
	
	
}
