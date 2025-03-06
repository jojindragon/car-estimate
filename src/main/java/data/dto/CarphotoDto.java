package data.dto;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("CarphotoDto")
public class CarphotoDto {
	private int idx;
	private int id;
	private String sidephoto; // 옆면 사진
	private String forntphoto; // 앞면 사진
}
