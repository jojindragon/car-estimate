package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.CarDto;
import data.dto.UserDto;

@Mapper
public interface UserMapper {
	public int checkUserID(String userId);
	public int checkNickname(String nickname);
	public void insertUser(UserDto dto);
	public int loginCheck(String loginid,String loginpass);
	public void changeProfile(String profile,int id);
	public List<UserDto> getAllUsers();
	public UserDto getUserById(int id);
	public UserDto getUserByUserId(String userId);
	public void updateUser(UserDto dto);
	public void deleteUser(int id);
	public void mypagecart(CarDto dto);
}
