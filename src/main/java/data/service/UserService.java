package data.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.dto.UserDto;
import data.mapper.UserMapper;

@Service
public class UserService {
	@Autowired
	UserMapper userMapper;
	
	// 유효성 검사들
	public boolean checkUserID(String userId) {
		return userMapper.checkUserID(userId)==1?true:false;
	}
	
	public boolean checkNickname(String nickname) {
		return userMapper.checkNickname(nickname)==1?true:false;
	}
	
	// 회원가입
	public void insertUser(UserDto dto) {
		userMapper.insertUser(dto);
	}
	
	// 로그인
	public boolean loginCheck(String loginid,String loginpass)
	{
		return userMapper.loginCheck(loginid, loginpass)==1?true:false;
	}
	
	// 유저 정보 얻기
	public List<UserDto> getAllUsers() {
		return userMapper.getAllUsers();
	}
	
	public UserDto getUserById(int id) {
		return userMapper.getUserById(id);
	}
	
	public UserDto getUserByUserId(String userId) {
		return userMapper.getUserByUserId(userId);
	}
	
	
	// 유저 프로필 변경
	public void changeProfile(String profile,int id)
	{
		userMapper.changeProfile(profile, id);
	}
	
	// 유저 정보 수정
	public void updateUser(UserDto dto)
	{
		userMapper.updateUser(dto);
	}
	
	// 유저 정보 삭제
	public void deleteUser(int id)
	{
		userMapper.deleteUser(id);
	}
}
