package cn.edu.tit.user.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.edu.tit.course.Iservice.ICourseService;
import cn.edu.tit.course.bean.Course;
import cn.edu.tit.user.Iservice.IUserService;
import cn.edu.tit.user.bean.User;
import cn.edu.tit.util.RoleUtil;
import cn.itcast.commons.CommonUtils;
import cn.itcast.vcode.utils.VerifyCode;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private ICourseService courseService;
	@Autowired
	private IUserService userService;
	@Autowired
	private RoleUtil roleUtil;

	private VerifyCode vc = new VerifyCode();

	/**
	 * 验证用户身份
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/checkIdentity")
	public String checkIdentity(HttpServletRequest request) {
		// 获取表单数据
		// 创建session
		HttpSession session = request.getSession();
		String user_id = request.getParameter("userid");
		String password = request.getParameter("password");
		User user = null;
		if (user_id != null && !("".equals(user_id))) {
			try {
				Map<String, Object> userMap = userService.userSignIn(user_id, password);
				// System.out.println(userMap);
				String page = (String) userMap.get("2");
				user = (User) userMap.get("1");
				session.setAttribute("user", user);
				return page;
			} catch (Exception e) {
				e.printStackTrace();
				// 登录失败，跳回登录界面，返回错误信息
				String page = roleUtil.getPage("login");
				return page;
			}
		} else {
			// 用户id为空，返回登录界面，输出错误信息"用户名或密码错误"
			String page = roleUtil.getPage("login");
			return page;
		}

	}

	// 更改用户信息
	@RequestMapping(value = "/changeInfo")
	public String ChangeInfo(HttpServletRequest request) {
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}

		request.setAttribute("user", user);

		return "jsp/user/regiest";
	}

	// 提交用户信息的更改
	@RequestMapping(value = "/userSignUP")
	public String userSignUP(HttpServletRequest request) {

		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		User user_temp = new User();
		try {
			String path = "D:\\accessory\\";
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(4194304); // 设置最大文件尺寸，这里是4MB
			List<FileItem> items = upload.parseRequest(request);// 得到所有的文件
			Map<String, Object> formdata = new HashMap<String, Object>();
			String name = "";
			for (FileItem fi : items) {
				if (!fi.isFormField()) {
					String fileName = fi.getName();
					if (fileName != null) {
						File fullFile = new File(new String(fi.getName().getBytes(), "utf-8")); // 解决文件名乱码问题
						name = System.currentTimeMillis() + fullFile.getName();
						File savedFile = new File(path, name);
						fi.write(savedFile);
						formdata.put(fi.getFieldName(), name);
					}
				} else {
					formdata.put(fi.getFieldName(), fi.getString("UTF-8"));
				}
			}
			user_temp = CommonUtils.toBean(formdata, User.class);
			user.setUpdate_user(user_temp.getUser_id());
			user.setPassword(user_temp.getPassword());
			user.setMobile(user_temp.getMobile());
			user.setFace(name);

			// 调用更新信息方法
			userService.ChangeInfo(user);
		} catch (Exception e) {
			System.out.println("更新失败");
			e.getMessage();
			return "jsp/user/regiest";
		}

		String page = roleUtil.getPage("login");
		return page;

	}

	/**
	 * 验证码
	 */
	@RequestMapping(value = "/verifyCode")
	public void verifyCode(HttpServletRequest request, HttpServletResponse response) {
		BufferedImage image = vc.getImage();// 获取一次性验证码图片
		String tString = vc.getText();
		// 该方法必须在getImage()方法之后来调用
		// System.out.println(vc.getText());//获取图片上的文本
		try {
			VerifyCode.output(image, response.getOutputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // 把图片写到指定流中

		// 把文本保存到session中，为LoginServlet验证做准备
		request.getSession().setAttribute("vCode", tString);
	}

	/**
	 * 用户登录
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/login")
	public String login(HttpServletRequest request) {
		String username = request.getParameter("loginname");
		String password = request.getParameter("loginpass");
		String verifycode = request.getParameter("verifyCode");
		String vCode = vc.getText();
		/*
		 * if(!verifycode.equalsIgnoreCase(vCode)) { request.setAttribute("msg",
		 * "验证码错误"); return "jsp/user/login"; }
		 */
		HttpSession session = request.getSession();
		User user = userService.login(username, password);
		if (user == null) {
			request.setAttribute("msg", "用户名或密码错误");
			return "jsp/user/login";
		} else {
			// request.getSession().setAttribute("user", user);
			session.setAttribute("user", user);

			// User user2 = (User) request.getSession().getAttribute("user");
			return tomain(request, 5);
		}
	}

	@RequestMapping(value = "/formlogin")
	public void formLogin(HttpServletRequest request) {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		HttpSession session = request.getSession();
		User user = userService.login(username, password);
		if (user == null)
			request.setAttribute("msg", "用户名或密码错误");
		else
			session.setAttribute("user", user);
		;
	}

	/**
	 * 用户退出
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/exit")
	public String Exit(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("user", null);
		return tomain(request, 5);
	}

	/**
	 * 跳转到主页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/tomain/{depart_id}")
	public String tomain(HttpServletRequest request, @PathVariable int depart_id) {
		HttpSession session = request.getSession();
		User user;
		if (session.getAttribute("user") != null) {
			user = (User) session.getAttribute("user");
			request.setAttribute("user", user);
			session.setAttribute("user", user);
		}
		// 添加课程列表
		List<Course> bestCourse = new ArrayList<>();
		List<Course> allCourses = courseService.findallCourse();
		if (allCourses.size() > 5) {
			for (int i = 0; i < 5; ++i)
				bestCourse.add(allCourses.get(i));
		} else
			bestCourse = allCourses;

		List<Course> temp = courseService.findCByDe(depart_id);
		List<Course> courses = null;
		Course course_1 = null;
		if (temp.size() < 1) {
			course_1 = null;
			courses = null;
		} else if (temp.size() == 1) {
			course_1 = temp.get(0);
			courses = null;
		} else {
			course_1 = temp.get(0);
			courses = null;
			if (temp.size() > 6)
				courses = temp.subList(1, 7);
			else
				courses = temp.subList(1, temp.size());
		}

		String name = null;
		// 添加课程名称
		switch (depart_id) {
		case 1:
			name = "machine";
			break;
		case 2:
			name = "auto";
			break;
		case 3:
			name = "electric";
			break;
		case 5:
			name = "computer";
			break;
		case 9:
			name = "manage";
		}
		request.setAttribute("name", name);
		request.setAttribute("course_1", course_1);
		request.setAttribute("courses", courses);
		request.setAttribute("mycourses", bestCourse);

		return "jsp/main";
	}

	public boolean w_Role(String user_id) {
		return userService.w_Role(user_id);
	}

	@RequestMapping(value = "/UplistTask")
	public String UplistTask() {
		return "jsp/UplistTask";
	}
}
