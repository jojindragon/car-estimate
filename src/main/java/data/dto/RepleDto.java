package data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
@Alias("RepleDto")
public class RepleDto {
	private int repldId;
	private int id; // user의 pk
	private int idx; // board의 pk
	private String message;
	private int readcount;
	private int regroup;
	private int relevel;
	private int restep;
	private String photo;
	@JsonFormat(pattern = "yyyy.MM.dd HH:mm", timezone = "Asia/Seoul")
	private Timestamp writeday;
}
