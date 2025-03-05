package data.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.mapper.UserMapper;

@Service
public class UserService {
	@Autowired
	UserMapper userMapper;
}
