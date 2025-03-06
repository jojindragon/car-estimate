package car.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import data.dto.CarDto;
import data.dto.CarphotoDto;
import data.service.CarService;
import data.service.CarphotoService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CarListController {
	final CarService carService;
	final CarphotoService carphotoService;
	
	@GetMapping("/")
	public String main(Model model) {
		List<String> list = carService.getCarTypes();
		model.addAttribute("typelist", list);
		model.addAttribute("carurl", "https://kr.object.ncloudstorage.com/bucket-mini-139");
		return "main/mainpage";
	}
	
	
	@GetMapping("/carlist")
	@ResponseBody
	public List<CarDto> carList(@RequestParam String type) {
		List<CarDto> list = carService.getCarList(type);
		
		// 사진 값 같이 가져오기
		for(CarDto c:list) {
			CarphotoDto dto = carphotoService.getCarPhoto(c.getIdx());
			String side = dto.getSidephoto();
			String front = dto.getFrontphoto();
			
			c.setSidephoto(side);
			c.setFrontphoto(front);
		}
		
		return list;
	}
}
