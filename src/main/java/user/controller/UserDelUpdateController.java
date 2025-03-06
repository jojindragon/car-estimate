package user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import data.dto.UserDto;
import data.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import naver.storage.NcpObjectStorageService;

@Controller
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserDelUpdateController {
	
	final UserService userService;
	final NcpObjectStorageService storageService;
	
	private String bucketName="bucket-mini-139";
	
	
	@PostMapping("/changeprofile")
	@ResponseBody
	public void changePhoto(
			@RequestParam("upload") MultipartFile upload,
			@RequestParam("id") int id,
			HttpSession session
			)
	{
		String userId = (String) session.getAttribute("loginid");
		String oldFilename=userService.getUserByUserId(userId).getProfile();
				
		storageService.deleteFile("bucketName", "user", oldFilename);
		
		String uploadFilename=storageService.uploadFile(bucketName, "user", upload);
		userService.changeProfile(uploadFilename, id);
		session.setAttribute("profile", uploadFilename);
	}
	
	@PostMapping("/update")
	@ResponseBody
	public void update(@ModelAttribute UserDto dto)
	{
		System.out.println(dto.getId());
		
		userService.updateUser(dto);
	}
	
}
