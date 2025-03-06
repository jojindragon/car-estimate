package data.mapper;

import org.apache.ibatis.annotations.Mapper;

import data.dto.CarphotoDto;

@Mapper
public interface CarphotoMapper {
	public void insertCarPhoto(CarphotoDto dto);
	public CarphotoDto getCarPhoto(int idx);
}
