package car.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import data.dto.CarDto;
import data.dto.CarphotoDto;
import data.service.CarService;
import data.service.CarphotoService;
import data.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import naver.storage.NcpObjectStorageService;

@Controller
@RequestMapping("/car")
@RequiredArgsConstructor
public class CarController {
	final UserService userService;
	final CarService carService;
	final CarphotoService carphotoService;
	final NcpObjectStorageService storageService;
	
	private String bucketName = "bucket-mini-139";
	
	// 차량 등록 폼으로
	@GetMapping("/addform")
	public String addForm(HttpSession session) {
		Boolean admin = (Boolean)session.getAttribute("admin");
		
		// 비 로그인 또는 관리자가 아닌 경우
		if(admin==null||!admin) {
			return "redirect:../";
		}
		
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
		
		return "redirect:./detail?idx="+dto.getIdx();
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
	
	// 차량 수정
	@PostMapping("/upload")
	public String carUpload(@ModelAttribute CarDto dto,
			@RequestParam("supload") MultipartFile supload,
			@RequestParam("fupload") MultipartFile fupload) {
		String side = dto.getSidephoto();
		String front = dto.getFrontphoto();
		
		if(!supload.getOriginalFilename().equals("")) {
			storageService.deleteFile(bucketName, "car", side);
			side = storageService.uploadFile(bucketName, "car", supload);
		}
		
		if(!fupload.getOriginalFilename().equals("")) {
			storageService.deleteFile(bucketName, "car", front);
			front = storageService.uploadFile(bucketName, "car", fupload);
		}
		
		// 차량 정보 수정
		carService.updateCar(dto);
		
		// 사진 수정
		CarphotoDto pdto = new CarphotoDto();
		pdto.setIdx(dto.getIdx());
		pdto.setSidephoto(side);
		pdto.setFrontphoto(front);
		
		carphotoService.updateCarPhoto(pdto);
		
		return "redirect:./detail?idx="+dto.getIdx();
	}
	
	@GetMapping("/getcar")
	@ResponseBody
	public void getCar(@RequestParam int idx) {
		carService.getCar(idx);
	}
	
	@GetMapping("/deletecar")
	@ResponseBody
	public void deleteCar(@RequestParam int idx) {
		// 스토리지 삭제
		CarphotoDto dto = carphotoService.getCarPhoto(idx);
		storageService.deleteFile(bucketName, "car", dto.getFrontphoto());
		storageService.deleteFile(bucketName, "car", dto.getSidephoto());
		
		// 차량 정보 삭제
		carService.deleteCar(idx);
	}
	
	/* 장바구니 시작 */
	// 장바구니 있는지 확인
	@GetMapping("/checkcart")
	@ResponseBody
	public Map<String, String> checkCart(HttpSession session, @RequestParam int idx) {
		Map<String, String> map = new HashMap<>();
		
		String userId= (String) session.getAttribute("loginid");
		int id = 0;
		if(userId == null) {
			id = 0;
		} else {
			id = userService.getUserByUserId(userId).getId();
		}
		
		
		if(carService.checkcart(id, idx)) {
			map.put("result", "fail");
		} else {
			map.put("result", "success");
		}
		
		return map;
	}
	
	// 장바구니 넣기
	@GetMapping("/incart")
	@ResponseBody
	public void inCart(HttpSession session, @RequestParam int idx) {
		String userId= (String) session.getAttribute("loginid");
		int id = userService.getUserByUserId(userId).getId();
		
		carService.insertcart(id, idx);
	}
	// 장바구니 빼기
	@GetMapping("/outcart")
	@ResponseBody
	public void outCart(HttpSession session, @RequestParam int idx) {
		String userId= (String) session.getAttribute("loginid");
		int id = userService.getUserByUserId(userId).getId();
		
		carService.deletecart(id, idx);
	}
	
}
