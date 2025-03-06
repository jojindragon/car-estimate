package data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
@Alias("CarDto")
public class CarDto {
	private int idx;
	private String name;
	private int price;
	private String type;
	private String excolor;
	private String incolor;
	private int cnt;
	@JsonFormat(pattern = "yyyy.MM.dd HH:mm", timezone = "Asia/Seoul")
	private Timestamp registerday;
	
	// 차량 사진
	private String sidephoto;
	private String frontphoto;
	
}
