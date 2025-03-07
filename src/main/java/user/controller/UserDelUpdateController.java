package user.controller;

import java.util.List;

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
	public void changePhoto(@RequestParam("upload") MultipartFile upload,
			@RequestParam("id") int id, HttpSession session) {
		String userId = (String) session.getAttribute("loginid");
		String oldFilename=userService.getUserByUserId(userId).getProfile();
				
		storageService.deleteFile(bucketName, "user", oldFilename);
		
		String uploadFilename=storageService.uploadFile(bucketName, "user", upload);
		userService.changeProfile(uploadFilename, id);
		session.setAttribute("profile", uploadFilename);
	}
	
	@PostMapping("/update")
	@ResponseBody
	public void update(@ModelAttribute UserDto dto) {
		userService.updateUser(dto);
	}
	
	@GetMapping("/delete")
	public String deleteUser(@RequestParam int id, HttpSession session)
	{
		String loginid = (String)session.getAttribute("loginid");
		if(loginid == null) {
			loginid = "";
		}
		
		UserDto dto = userService.getUserById(id);
		
		if(dto.getUserId().equals(loginid)) {
			session.removeAttribute("loginstatus");
			session.removeAttribute("loginid");
			session.removeAttribute("admin");
		}
		
		storageService.deleteFile(bucketName, "user", dto.getProfile());
		userService.deleteUser(id);
		return "redirect:../";
	}
	
	@GetMapping("/mypagedel")
	@ResponseBody
	public void mypageDelete(@RequestParam int id, HttpSession session)
	{
		UserDto dto = userService.getUserById(id);
		storageService.deleteFile(bucketName, "user", dto.getProfile());
		userService.deleteUser(id);
		
		session.removeAttribute("loginstatus");
		session.removeAttribute("loginid");
		session.removeAttribute("admin");	
	}
	

	@GetMapping("/manage")
	public String usermanage(HttpSession session, Model model) {
		Boolean admin = (Boolean)session.getAttribute("admin");
		
		// 비 로그인 또는 관리자가 아닌 경우
		if(admin==null||!admin) {
			return "redirect:../";
		}
		
		model.addAttribute("naverurl", "https://kr.object.ncloudstorage.com/"+bucketName);
		return "user/usermanage";
	}
	
	@GetMapping("/userlist")
	@ResponseBody
	public List<UserDto> userList() {
		List<UserDto> list = userService.getAllUsers();
		return list;
	}
	
	@PostMapping("setadmin")
	@ResponseBody
	public void setAdmin(@RequestParam int id) {
		userService.setAdmin(id);
	}
	
}