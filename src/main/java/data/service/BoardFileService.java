package data.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.mapper.BoardFileMapper;

@Service
public class BoardFileService {
	@Autowired
	BoardFileMapper boardFileMapper;
	
	
	
}
