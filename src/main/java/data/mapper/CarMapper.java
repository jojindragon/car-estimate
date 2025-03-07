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
	public void updateCar(CarDto dto);
	public void getCar(int idx);
	public void deleteCar(int idx);
	public int checkcart(int id, int idx);
	public void insertcart(int id, int idx);
	public void deletecart(int id, int idx);
	public List<CarDto> mypagecart(int id);
}
