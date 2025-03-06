package data.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.CarDto;
import data.mapper.CarMapper;

@Service
public class CarService {
	@Autowired
	CarMapper carMapper;
	
	// 차량 정보 삽입
	public void insertCar(CarDto dto) {
		carMapper.insertCar(dto);
	}
	
	// 차량 데이터(리스트) 가져오기
	public List<CarDto> getCarList(String type) {
		return carMapper.getCarList(type);
	}
	
	// 차량 태그 리스트 가져오기
	public List<String> getCarTypes() {
		return carMapper.getCarTypes();
	}

	// 차량 자세히보기
	public CarDto getCarData(int idx) {
		return carMapper.getCarData(idx);
	}
}
