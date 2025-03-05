package data.mapper;

import org.apache.ibatis.annotations.Mapper;

import data.dto.UserDto;

@Mapper
public interface UserMapper {
	public int checkUserID(String userId);
	public int checkNickname(String nickname);
	public void insertUser(UserDto dto);
}
