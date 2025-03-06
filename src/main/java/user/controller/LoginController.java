package user.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import data.dto.UserDto;
import data.service.UserService;
import jakarta.servlet.http.HttpSession;

@RestController
public class LoginController {

	@Autowired
	UserService userService;
	
	@PostMapping("/login")
	public Map<String, String> login(
			@RequestParam String loginid,@RequestParam String loginpass,
			HttpSession session
			)
	{
		Map<String, String> map=new HashMap<>();
		boolean b=userService.loginCheck(loginid, loginpass);
		
		if(b) {
			UserDto dto = userService.getUserByUserId(loginid);
			session.setMaxInactiveInterval(60*60*4);
			session.setAttribute("loginstatus", "success");
			session.setAttribute("loginid", loginid);
			session.setAttribute("admin", dto.getAdmin());
		}
		
		map.put("result", b?"success":"fail");
		
		return map;
	}
	
	@GetMapping("/logout")
	public void userLogout(HttpSession session)
	{
		session.removeAttribute("loginstatus");
		session.removeAttribute("loginid");
		session.removeAttribute("admin");
	}
}
