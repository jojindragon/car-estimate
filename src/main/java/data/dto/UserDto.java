package data.dto;

import java.sql.Timestamp;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
@Alias("UserDto")
public class UserDto {
	private int id;
	private String userId;
	private String password;
	private String nickname;
	private String profile;
	private String phone;
	private String addr;
	private Boolean admin;
	@JsonFormat(pattern = "yyyy.MM.dd HH:mm", timezone = "Asia/Seoul")
	private Timestamp createday;
}
