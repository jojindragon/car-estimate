package car.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import data.dto.CarDto;
import data.dto.CarphotoDto;
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
	
	// 차량 등록 폼으로
	@GetMapping("/addform")
	public String addForm() {
		return "car/addcar";
	}
	
	// 차량 정보 넣기
	@PostMapping("/insert")
	public String addCar(@ModelAttribute CarDto dto,
			@RequestParam("supload") MultipartFile supload,
			@RequestParam("fupload") MultipartFile fupload) {
		// dto 삽입 - 자동으로 idx 값 획득됨
		carService.insertCar(dto);
		
		// 사진 삽입
		String side = storageService.uploadFile(bucketName, "car", supload);
		String front = storageService.uploadFile(bucketName, "car", fupload);
		
		CarphotoDto pdto = new CarphotoDto();
		pdto.setIdx(dto.getIdx());
		pdto.setSidephoto(side);
		pdto.setFrontphoto(front);
		
		carphotoService.insertCarPhoto(pdto);
		
		return "redirect:../"; // 메인 페이지로 이동
	}
	
	// 차량 자세히보기
	@GetMapping("/detail")
	public String carDetail(Model model, @RequestParam int idx) {
		CarDto dto = carService.getCarData(idx);
		dto.setSidephoto(carphotoService.getCarPhoto(idx).getSidephoto());
		dto.setFrontphoto(carphotoService.getCarPhoto(idx).getFrontphoto());
		model.addAttribute("dto", dto);
		model.addAttribute("carurl", "https://kr.object.ncloudstorage.com/"+bucketName);
		return "car/cardetail";
	}
}
