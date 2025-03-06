package data.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.CarphotoDto;
import data.mapper.CarphotoMapper;

@Service
public class CarphotoService {
	@Autowired
	CarphotoMapper carphotoMapper;

	// 사진 삽입
	public void insertCarPhoto(CarphotoDto dto) {
		carphotoMapper.insertCarPhoto(dto);
	}
	
	// 각 상품 사진 가져오기
	public CarphotoDto getCarPhoto(int idx) {
		return carphotoMapper.getCarPhoto(idx);
	}
	
}
