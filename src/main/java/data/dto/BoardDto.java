package data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
@Alias("BoardDto")
public class BoardDto {
	private int idx;
	private int id; //user pk
	private String subject;
	private String content;
	private int readcount;
	private int regroup;
	private int relevel;
	private int restep;
	private boolean notice; // 공지글 여부
	@JsonFormat(pattern = "yyyy.MM.dd HH:mm", timezone = "Asia/Seoul")
	private Timestamp writeday;
}
