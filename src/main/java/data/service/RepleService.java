package data.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.mapper.RepleMapper;

@Service
public class RepleService {
	@Autowired
	RepleMapper repleMapper;
	
	// 댓글 작업
}
