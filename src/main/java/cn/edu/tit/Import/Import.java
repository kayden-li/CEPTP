package cn.edu.tit.Import;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/manage")
public class Import {
	@RequestMapping(value = "/entry")
	public String toEntry() {
		return "jsp/user/initialise";
	}
}
