package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.CarDto;

@Mapper
public interface CarMapper {
	public void insertCar(CarDto dto);
	public List<CarDto> getCarList(String type);
	public List<String> getCarTypes();
	public CarDto getCarData(int idx);
}
