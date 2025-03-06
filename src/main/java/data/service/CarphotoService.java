package data.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.mapper.CarphotoMapper;

@Service
public class CarphotoService {
	@Autowired
	CarphotoMapper carphotoMapper;
	
}
