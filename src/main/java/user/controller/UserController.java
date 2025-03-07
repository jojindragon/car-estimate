package user.controller;

import java.util.HashMap;
import java.util.Map;

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
public class UserController {
	final UserService userService;
	final NcpObjectStorageService storageService;
	
	private String bucketName = "bucket-mini-139";
	
	@GetMapping("/regifrm")
	public String registerForm() {
		// 회원가입 폼으로
		return "user/register";
	}
	
	@GetMapping("/idcheck")
	@ResponseBody
	public Map<String, String> idCheck(@RequestParam String userId) {
		// 아이디 유효성 검사
		Map<String, String> map = new HashMap<>();
		
		if(userService.checkUserID(userId)) {
			map.put("result", "fail");
		} else {
			map.put("result", "success");
		}
		
		return map;
	}
	
	@GetMapping("/nickcheck")
	@ResponseBody
	public Map<String, String> nicknameCheck(@RequestParam String nickname) {
		// 닉네임 유효성 검사
		Map<String, String> map = new HashMap<>();
		
		if(userService.checkNickname(nickname)) {
			map.put("result", "fail");
		} else {
			map.put("result", "success");
		}
		
		return map;
	}
	
	@PostMapping("/register")
	public String register(@ModelAttribute UserDto dto,
			@RequestParam("upload") MultipartFile upload) {
		// 회원가입
		if(upload.getOriginalFilename().equals("")) {
			dto.setProfile("no");
		} else {
			String profile = storageService.uploadFile(bucketName, "user", upload);
			dto.setProfile(profile);
		}
		
		userService.insertUser(dto);
		
		return "redirect:../";
	}
	
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		String userId = (String)session.getAttribute("loginid");
		if(userId==null) {
			return "redirect:../";
		}
		UserDto dto = userService.getUserByUserId(userId);
		
		model.addAttribute("dto", dto);
		model.addAttribute("naverurl", "https://kr.object.ncloudstorage.com/"+bucketName);
		
		return "user/mypage";
	}
	
	@GetMapping("/mypagecart")
	@ResponseBody
	public String mypagecart(HttpSession session, Model model) {
		String userId =(String) session.getAttribute("userId");
	
//		model.addAttribute("dto", dto);
		model.addAttribute("naverurl", "https://kr.object.ncloudstorage.com/"+bucketName);
	
		return "mypagecart";
		}
}
