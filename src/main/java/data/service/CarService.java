package data.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import data.mapper.CarMapper;

@Service
public class CarService {
	@Autowired
	CarMapper carMapper;
	
	
	
}
