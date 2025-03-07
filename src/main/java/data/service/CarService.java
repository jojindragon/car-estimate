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
	
	// 차량 정보 수정
	public void updateCar(CarDto dto) {
		carMapper.updateCar(dto);
	}
	
	// 차량 구매 - cnt 감소
	public void getCar(int idx) {
		carMapper.getCar(idx);
	}
	
	// 차량 정보 삭제
	public void deleteCar(int idx) {
		carMapper.deleteCar(idx);
	}
	
	// 장바구니 - carlist 테이블 관련
	// 장바구니 검사
	public boolean checkcart(int id, int idx) {
		return carMapper.checkcart(id, idx)==1?true:false;
	}
	
	// 장바구니 담기
	public void insertcart(int id, int idx) {
		carMapper.insertcart(id, idx);
	}
	
	// 장바구니 지우기
	public void deletecart(int id, int idx) {
		carMapper.deletecart(id, idx);
	}
	
	public List<CarDto> mypagecart(int id) {
		return carMapper.mypagecart(id);
	}
}
