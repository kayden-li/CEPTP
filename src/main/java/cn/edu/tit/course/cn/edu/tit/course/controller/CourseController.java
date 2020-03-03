package cn.edu.tit.course.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import cn.edu.tit.course.Iservice.ICourseService;
import cn.edu.tit.course.bean.Accessory;
import cn.edu.tit.course.bean.Course;
import cn.edu.tit.course.bean.Depart;
import cn.edu.tit.course.bean.Task;
import cn.edu.tit.pager.PagerBean;
import cn.edu.tit.user.Iservice.IUserService;
import cn.edu.tit.user.bean.User;
import cn.edu.tit.user.utils.getByte;
import cn.edu.tit.util.FileUtil;
import cn.edu.tit.util.RoleUtil;
import cn.itcast.commons.CommonUtils;

@Controller
@RequestMapping("/course")
public class CourseController {
	@Autowired
	private ICourseService courseService;
	@Autowired
	private IUserService userService;
	@Autowired
	private FileUtil fileUtil;
	@Autowired
	private RoleUtil roleUtil;

	/**
	 * 获取到当前页页码
	 */
	private int getPc(int rpc) {
		int pc = 1;
		int param = rpc;

		if (rpc != 0) {
			pc = rpc;

		}
		return pc;
	}

	private String getUrl(HttpServletRequest req) {
		String url = req.getRequestURI();
		int index = url.lastIndexOf("/");
		url = url.substring(0, index);
		return url;
	}

	/**
	 * 分页查找课程
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/findCouByPage/{course_label}/{page}")
	public String findCouByPage(HttpServletRequest request, @PathVariable String course_label, @PathVariable int page) {
		// 获取当前页码
		int pc = getPc(page);
		// 获取课程相应pagebean
		PagerBean<Course> pcourse = courseService.getCPage(pc, course_label);
		pcourse.setUrl(getUrl(request));
		// List<String> usernames = new ArrayList<>();
		// for(Course c:pcourse.getBeanList()){
		// usernames.add(userService.findUserById(c.getCreate_user()).getUser_name());
		// }
		User user = (User) request.getSession().getAttribute("user");

		request.setAttribute("user", user);
		request.setAttribute("courseList", pcourse.getBeanList());
		// request.setAttribute("usernames", usernames);
		request.setAttribute("pb", pcourse);
		return "jsp/dep_course";
	}

	/**
	 * 添加课程
	 * 
	 * @param request
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/addCourse")
	public String addCourse(HttpServletRequest request) throws UnsupportedEncodingException {
		// 获取课程相关信息
		Course course = new Course();
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		String course_id = user.getUser_id() + "_" + System.currentTimeMillis(); // 课程id
		// int course_lable = 2; // 类型
		int course_flag = 1; // 状态
		String invitation_code = UUID.randomUUID().toString().replace("-", "").toUpperCase().substring(0, 6); // 邀请码
		try {
			String path = "D:\\accessory\\";
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(506317499); // 设置最大文件尺寸，这里是4MB
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
			course = CommonUtils.toBean(formdata, Course.class);
			course.setCourse_id(course_id);
			course.setCourse_flag(course_flag);
			course.setCourse_img(name);
			// course.setCourse_label(course_label);
			course.setInvitation_code(invitation_code);
			course.setCreate_user(user.getUser_id());
			course.setPublisher(user.getUser_name());
			course.setUpdate_user(user.getUser_id());
			courseService.createCourse(course);
			return tomain(request, 5);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping(value = "/tomain/{depart_id}")
	public String tomain(HttpServletRequest request, @PathVariable int depart_id) {

		HttpSession session = request.getSession();
		User user;
		if (session.getAttribute("user") != null) {
			user = (User) session.getAttribute("user");
			request.setAttribute("user", user);
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
		if (temp.size() == 0) {
			course_1 = null;
			courses = null;
		} else if (temp.size() == 1) {
			course_1 = temp.get(0);
			courses = null;
		} else {
			course_1 = temp.get(0);
			courses = null;
			if (temp.size() > 6)
				courses = temp.subList(1, 6);
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

	/**
	 * 加入课程
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/joinCourse/{code}")
	public String joinCourse(HttpServletRequest request, HttpServletResponse response, @PathVariable String code)
			throws IOException {
		// 获取加入者id和邀请码
		User user = (User) request.getSession().getAttribute("user");
		String invitation_code = code;
		// 调用业务逻辑
		Boolean state = courseService.joinCourse(invitation_code, user.getUser_id());
		if (!state) {
			response.setContentType("text/html; charset=UTF-8"); // 转码
			PrintWriter out = response.getWriter();
			out.flush();
			out.println("<script>");
			out.println("alert('加入失败');");
			out.println("history.back();");
			out.println("</script>");
		}
		return toIntoActivitiest(request, user.getUser_id());
	}

	/**
	 * 发布任务
	 * 
	 * @param request
	 */
	@RequestMapping(value = "/publishTask")
	public String publishTask(HttpServletRequest request, HttpServletResponse response) {

		User user = (User) request.getSession().getAttribute("user");
		request.setAttribute("user", user);
		try {
			String path = "D:\\accessory\\";
			// 创建工厂
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(4194304); // 设置最大文件尺寸，这里是4MB

			List<Accessory> accList = new ArrayList<>();
			List<FileItem> items = upload.parseRequest(request);// 得到所有的文件
			Map<String, Object> formdata = new HashMap<String, Object>();
			String name = "";
			for (FileItem fi : items) {
				Accessory acc = new Accessory();
				if (!fi.isFormField()) {
					String fileName = fi.getName();
					if (fileName != null) {
						File fullFile = new File(new String(fi.getName().getBytes(), "utf-8")); // 解决文件名乱码问题
						File savedFile = new File(path, fullFile.getName());
						fi.write(savedFile);
						if (!fullFile.getName().equals(name)) {
							acc.setAccessory_name(fullFile.getName());
							acc.setAccessory_id(user.getUser_name() + System.currentTimeMillis());
							acc.setAccessory_kind(1);
							acc.setAccessory_path(path + acc.getAccessory_name());
							acc.setCreate_user(user.getUser_id());
							accList.add(acc);
							name = fullFile.getName();
						}

					}
				} else {
					formdata.put(fi.getFieldName(), fi.getString("UTF-8"));
				}
			}
			Task task = CommonUtils.toBean(formdata, Task.class);
			String task_id = task.getCourse_id() + System.currentTimeMillis();
			for (Accessory a : accList) {
				a.setTask_id(task_id);
			}
			task.setTask_id(task_id);
			task.setStatus(1);
			task.setPubAccs(accList);
			task.setEvaluate_kind("教师评价");
			task.setEvaluate_id(user.getUser_id());
			task.setCreate_user(user.getUser_id());
			task.setTask_type(formdata.get("task_type").toString());
			String check = task.getTask_type();
			// 调用service方法
			if ("0".equals(check))
				courseService.addTask(task);
			else if ("1".equals(check))
				courseService.addTest(task);
			else if ("2".equals(check)) {
				if ("".equals(task.getDelete_time()))
					task.setDelete_time(null);
				courseService.addResource(task);

			} else {
				if ("".equals(task.getDelete_time()))
					task.setDelete_time(null);
				courseService.addOther(task);
			}
			List<Task> taskList = new ArrayList<>();
			taskList = courseService.getTaskBycid(task.getCourse_id());
			request.setAttribute("course_id", task.getCourse_id());
			request.setAttribute("testList", courseService.getTestBycid(task.getCourse_id()));
			request.setAttribute("resourceList", courseService.getResourceBycid(task.getCourse_id()));
			request.setAttribute("taskList", taskList);
			request.setAttribute("memberList", courseService.getMember(task.getCourse_id()));
			request.setAttribute("Cname", courseService.secCourseByid(task.getCourse_id()));

			request.setAttribute("create_user", user.getUser_id());
			return "jsp/intoCourse";
		} catch (Exception e) {
			e.getMessage();
			return toIntoActivitiest(request, user.getUser_id());
		}

	}

	/**
	 * 提交任务
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/uploadTask/{uploadFlag}")
	public String uploadTask(HttpServletRequest request, @PathVariable int uploadFlag) {
		// 获取参数
		User uploader = (User) request.getSession().getAttribute("user");
		if (uploader == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		try {
			String path = "D:\\accessory\\";
			DiskFileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			upload.setSizeMax(4194304); // 设置最大文件尺寸，这里是4MB
			List<Accessory> accList = new ArrayList<>();
			List<FileItem> items = upload.parseRequest(request);// 得到所有的文件
			Map<String, Object> formdata = new HashMap<String, Object>();
			String name = "";
			for (FileItem fi : items) {
				Accessory acc = new Accessory();
				if (!fi.isFormField()) {
					String fileName = fi.getName();
					if (fileName != null) {
						File fullFile = new File(new String(fi.getName().getBytes(), "utf-8")); // 解决文件名乱码问题
						File savedFile = new File(path, fullFile.getName());
						fi.write(savedFile);
						if (!fullFile.getName().equals(name)) {
							acc.setAccessory_name(fullFile.getName());
							acc.setAccessory_id(uploader.getUser_id() + System.currentTimeMillis());
							acc.setAccessory_kind(2);
							acc.setAccessory_path(path + acc.getAccessory_name());
							acc.setCreate_user(uploader.getUser_id());
							accList.add(acc);
							name = fullFile.getName();
						}
					}
				} else {
					formdata.put(fi.getFieldName(), fi.getString("UTF-8"));
				}
			}
			Task task = CommonUtils.toBean(formdata, Task.class);

			task.setTask_id(task.getTask_id());
			for (Accessory a : accList) {
				a.setTask_id(task.getTask_id());
			}
			task.setUploader(uploader.getUser_id());
			task.setPubAccs(accList);
			Task pubtask = courseService.secTaskByid(task.getTask_id());
			task.setCreate_user(pubtask.getCreate_user());
			task.setTask_details(pubtask.getTask_details());
			// 调用service方法
			if (uploadFlag == 0) {
				courseService.uploadTask(task);
			} else {
				courseService.updateUpTask(task);

			}

			List<Task> taskList = new ArrayList<>();
			taskList = courseService.getTaskBycid(task.getCourse_id());
			request.setAttribute("user", uploader);
			request.setAttribute("course_id", task.getCourse_id());
			request.setAttribute("create_user", task.getCreate_user());
			request.setAttribute("taskList", taskList);
			request.setAttribute("testList", courseService.getTestBycid(task.getCourse_id()));
			request.setAttribute("resourceList", courseService.getResourceBycid(task.getCourse_id()));
			request.setAttribute("Cname", courseService.secCourseByid(task.getCourse_id()));

			return "jsp/intoCourse";
		} catch (Exception e) {
			e.getMessage();
			return null;
		}

	}

	@RequestMapping(value = "/showTask/{task_id}")
	public String showTask(HttpServletRequest request, @PathVariable String task_id) {
		Task task = courseService.secTaskByid(task_id);
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		Task upload_task = courseService.getUpload(task_id, user.getUser_id());
		if (upload_task != null) {
			List<Accessory> accList = new ArrayList<>();
			accList = courseService.getAccs(task_id, 2);
			if (accList.size() != 0) {
				upload_task.setUploadAccs(accList);
			}
			request.setAttribute("uploadFlag", 1);
			request.setAttribute("upload_task", upload_task);
		} else {
			request.setAttribute("uploadFlag", 0);
		}
		// 根据id查询所有附件
		List<Accessory> accList = new ArrayList<>();
		accList = courseService.getAccs(task_id, 1);
		if (accList.size() != 0)
			task.setPubAccs(accList);
		request.setAttribute("couid", task.getCourse_id());
		request.setAttribute("user", user);
		request.setAttribute("task", task);
		request.setAttribute("detail", task.getTask_details());
		return "jsp/uploadTask";
	}

	@RequestMapping(value = "/showTest/{task_id}")
	public String showTest(HttpServletRequest request, @PathVariable String task_id) {
		Task task = courseService.secTestByid(task_id);
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		Task upload_task = courseService.getUpload(task_id, user.getUser_id());
		if (upload_task != null) {
			List<Accessory> accList = new ArrayList<>();
			accList = courseService.getAccs(task_id, 2);
			if (accList.size() != 0) {
				upload_task.setUploadAccs(accList);
			}
			request.setAttribute("uploadFlag", 1);
			request.setAttribute("upload_task", upload_task);
		} else {
			request.setAttribute("uploadFlag", 0);
		}
		// 根据id查询所有附件
		List<Accessory> accList = new ArrayList<>();
		accList = courseService.getAccs(task_id, 1);
		if (accList.size() != 0)
			task.setPubAccs(accList);
		request.setAttribute("couid", task.getCourse_id());
		request.setAttribute("user", user);
		request.setAttribute("task", task);
		return "jsp/uploadTask";
	}

	@RequestMapping(value = "/showOther/{task_id}")
	public String showOther(HttpServletRequest request, @PathVariable String task_id) {
		Task task = courseService.secOtherByid(task_id);
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		Task upload_task = courseService.getUpload(task_id, user.getUser_id());
		if (upload_task != null) {
			List<Accessory> accList = new ArrayList<>();
			accList = courseService.getAccs(task_id, 2);
			if (accList.size() != 0) {
				upload_task.setUploadAccs(accList);
			}
			request.setAttribute("uploadFlag", 1);
			request.setAttribute("upload_task", upload_task);
		} else {
			request.setAttribute("uploadFlag", 0);
		}
		// 根据id查询所有附件
		List<Accessory> accList = new ArrayList<>();
		accList = courseService.getAccs(task_id, 1);
		if (accList.size() != 0)
			task.setPubAccs(accList);
		request.setAttribute("couid", task.getCourse_id());
		request.setAttribute("user", user);
		request.setAttribute("task", task);
		return "jsp/uploadTask";
	}

	@RequestMapping(value = "/showRes/{task_id}")
	public String showResource(HttpServletRequest request, @PathVariable String task_id) {
		Task task = courseService.secResByid(task_id);
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		Task upload_task = courseService.getUpload(task_id, user.getUser_id());
		if (upload_task != null) {
			List<Accessory> accList = new ArrayList<>();
			accList = courseService.getAccs(task_id, 2);
			if (accList.size() != 0) {
				upload_task.setUploadAccs(accList);
			}
			request.setAttribute("uploadFlag", 1);
			request.setAttribute("upload_task", upload_task);
		} else {
			request.setAttribute("uploadFlag", 0);
		}
		// 根据id查询所有附件
		List<Accessory> accList = new ArrayList<>();
		accList = courseService.getAccs(task_id, 1);
		if (accList.size() != 0)
			task.setPubAccs(accList);
		request.setAttribute("couid", task.getCourse_id());
		request.setAttribute("user", user);
		request.setAttribute("task", task);
		return "jsp/uploadTask";
	}

	/**
	 * 跳转到提交列表页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/toStudentUpList/{task_id}")
	public String toStudentUpList(HttpServletRequest request, @PathVariable String task_id) {

		User user2 = (User) request.getSession().getAttribute("user");
		if (user2 == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		// 根据taskid查询提交任务
		List<Task> upload = new ArrayList<>();
		List<User> uploader = new ArrayList<>();
		upload = courseService.getUploadByid(task_id);
		Task task = courseService.secTaskByid(task_id);
		// 根据id查询所有附件
		List<Accessory> accList = new ArrayList<>();
		accList = courseService.getAccs(task_id, 1);
		if (accList.size() != 0)
			task.setPubAccs(accList);
		request.setAttribute("task", task);

		for (Task up : upload) {
			User user = userService.findUserById(up.getUploader());
			user.setGrade(courseService.getTaskGrade(task_id, user.getUser_id()));
			uploader.add(user);
		}
		request.setAttribute("user", user2);
		request.setAttribute("uploader", uploader);
		return "jsp/studentUpList";
	}

	/**
	 * 跳转到提交任务详细页面
	 * 
	 * @param request
	 * @param task_id
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/toStuTaskDetail/{task_id}/{user_id}")
	public String toStuTaskDetail(HttpServletRequest request, @PathVariable String task_id,
			@PathVariable String user_id) {

		// 通过taskid和user查询用户提交的任务内容
		Task uploadT = courseService.getUpload(task_id, user_id);
		// 根据id查询所有附件
		if (uploadT != null) {
			List<Accessory> accList = new ArrayList<>();
			accList = courseService.getAccs(task_id, 2);
			uploadT.setUploadAccs(accList);
			User user = userService.findUserById(user_id);
			int grade = courseService.getTaskGrade(task_id, user_id);
			int status = courseService.getTaskStatus(task_id);
			user = (User) request.getAttribute("user");
			request.setAttribute("task", uploadT);
			request.setAttribute("user", user);
			request.setAttribute("name", userService.findUserById(user_id).getUser_name());
			request.setAttribute("id", user_id);
			request.setAttribute("grade", grade);
			request.setAttribute("status", status);

		}
		return "jsp/studentTaskDetail";
	}

	/**
	 * 评分，并再次跳转到任务详情页
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/setGrade/{task_id}/{user_id}/{upload_id}")
	public String setGrade(HttpServletRequest request, @PathVariable String task_id, @PathVariable String user_id,
			@PathVariable String upload_id) {
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		// 通过taskid和user查询用户提交的任务内容
		Task uploadT = courseService.getUpload(task_id, upload_id);
		// 根据id查询所有附件
		List<Accessory> accList = new ArrayList<>();
		accList = courseService.getAccs(task_id, 2);
		uploadT.setUploadAccs(accList);
		int grade = 0;
		if (!request.getParameter("grade").equals("")) {
			grade = Integer.parseInt(request.getParameter("grade"));
		} else {
			grade = 0;
		}
		int status = courseService.getTaskStatus(task_id);
		courseService.setgrade(grade, task_id, upload_id);
		request.setAttribute("task", uploadT);
		request.setAttribute("grade", grade);
		request.setAttribute("name", userService.findUserById(upload_id).getUser_name());
		request.setAttribute("id", upload_id);
		request.setAttribute("status", status);
		request.setAttribute("user", user);
		return "jsp/studentTaskDetail";
	}

	/**
	 * 跳转到修改成绩
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "toupdateGrade/{task_id}/{user_id}/{upload_id}")
	public String toupdateGrade(HttpServletRequest request, @PathVariable String task_id, @PathVariable String user_id,
			@PathVariable String upload_id) {
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		// 通过taskid和user查询用户提交的任务内容
		Task uploadT = courseService.getUpload(task_id, upload_id);
		// 根据id查询所有附件
		List<Accessory> accList = new ArrayList<>();
		accList = courseService.getAccs(task_id, 2);
		uploadT.setUploadAccs(accList);
		int status = courseService.getTaskStatus(task_id);
		request.setAttribute("task", uploadT);
		request.setAttribute("user", user);
		request.setAttribute("name", userService.findUserById(upload_id).getUser_name());
		request.setAttribute("id", upload_id);
		request.setAttribute("grade", -1);
		request.setAttribute("status", status);

		return "jsp/studentTaskDetail";
	}

	/**
	 * 下载文件
	 * 
	 * @param id
	 *            appid
	 * @param response
	 * @throws UnsupportedEncodingException
	 */
	@RequestMapping(value = "/download/{id}")
	public void download(@PathVariable String id, HttpServletResponse response, HttpServletRequest request)
			throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		String filepath = "";
		filepath = courseService.getaccPath(id);

		File file = new File(filepath);
		InputStream inputStream = null;
		OutputStream outputStream = null;
		byte[] b = new byte[1024];
		int len = 0;
		try {
			inputStream = new FileInputStream(file);
			outputStream = response.getOutputStream();

			response.setContentType("application/force-download");
			String filename = file.getName();
			response.addHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(filename, "UTF-8"));
			response.setContentLength((int) file.length());

			while ((len = inputStream.read(b)) != -1) {
				outputStream.write(b, 0, len);
			}
			courseService.addDownloadNum(id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (inputStream != null) {
				try {
					inputStream.close();
					inputStream = null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (outputStream != null) {
				try {
					outputStream.close();
					outputStream = null;
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 * 跳转到添加课程页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/toAddCourse")
	private String toAddCourse(HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user1 = (User) session.getAttribute("user");
		if (user1 == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		User user = userService.findUserById(user1.getUser_id());
		List<Depart> departList = new ArrayList<>();
		departList = courseService.getdepart();
		request.setAttribute("departs", departList);
		request.setAttribute("username", user.getUser_name());
		return "jsp/addCourse";

	}

	/**
	 * 跳转到课程详细页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/toIntoCourse/{course_id}/{create_user}")
	private String toIntoCourse(HttpServletRequest request, @PathVariable String course_id,
			@PathVariable String create_user) {
		// String user_id = (String) session.getAttribute("user_id");
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		request.setAttribute("username", user.getUser_name());
		// 根据courseid查任务
		List<Task> taskList = new ArrayList<>();
		taskList = courseService.getTaskBycid(course_id);
		for (Task task : taskList) {
			task.setNum(courseService.numOfTask(task.getTask_id()));
			request.setAttribute("taskList", taskList);
		}
		taskList = courseService.getTestBycid(course_id);
		for (Task task : taskList) {
			task.setNum(courseService.numOfTask(task.getTask_id()));
		}
		request.setAttribute("testList", taskList);
		request.setAttribute("create_user", create_user);
		request.setAttribute("user", user);
		request.setAttribute("role", userService.w_Role(user.getUser_id()));
		request.setAttribute("course_id", course_id);
		request.setAttribute("Cname", courseService.secCourseByid(course_id));
		request.setAttribute("resourceList", courseService.getResourceBycid(course_id));
		request.setAttribute("Cname", courseService.secCourseByid(course_id));
		List<Task> otherList = courseService.getOtherBycid(course_id);
		request.setAttribute("otherList", otherList);
		List<User> users = courseService.getMember(course_id);
		List<User> member = new ArrayList<>();
		for (User user2 : users)
			member.add(userService.findUserById(user2.getUser_id()));

		request.setAttribute("memberList", member);
		return "jsp/intoCourse";

	}

	/**
	 * 跳转到课程汇总页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/toIntoActivities/{user_id}")
	private String toIntoActivitiest(HttpServletRequest request, @PathVariable String user_id) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		request.setAttribute("username", user.getUser_name());

		// 根据userid查课程
		List<Course> courseList, courseList_temp, courses;
		courseList = courseService.findJoinCBySUser_id(user_id);
		courseList_temp = courseService.findJoinCByTUser_id(user_id);
		courses = new ArrayList<Course>(courseList_temp);
		try {
			for (Course course1 : courseList) {
				for (Course course2 : courseList_temp) {
					if (course2.getCourse_id().equals(course1.getCourse_id()))
						courses.remove(course2);
				}
			}
		} catch (Exception e) {

		}
		courseList.addAll(courses);
		// 获取任务列表
		for (Course course : courseList) {
			List<Task> temp = courseService.getTaskBycid(course.getCourse_id());
			if (temp.size() > 3) {
				List<Task> taskList = new ArrayList<>();
				taskList.addAll(temp.subList(0, 3));
				course.setTaskList(taskList);

			} else
				course.setTaskList(temp);
			for (Task task : course.getTaskList()) {
				task.setNum(courseService.numOfTask(task.getTask_id()));
			}
		}
		// 获取实验列表
		for (Course course : courseList) {
			List<Task> temp = courseService.getTestBycid(course.getCourse_id());
			if (temp.size() > 3) {
				List<Task> taskList = new ArrayList<>();
				taskList.addAll(temp.subList(0, 3));
				course.setTestList(taskList);
			} else
				course.setTestList(temp);
			for (Task task : course.getTestList()) {
				task.setNum(courseService.numOfTask(task.getTask_id()));
			}
		}
		// 获取资源列表
		for (Course course : courseList) {
			List<Task> temp = courseService.getResourceBycid(course.getCourse_id());
			if (temp.size() > 3) {
				List<Task> taskList = new ArrayList<>();
				taskList.addAll(temp.subList(0, 3));
				course.setResourceList(taskList);
			} else
				course.setResourceList(temp);
			for (Task task : course.getResourceList()) {
				task.setNum(courseService.numOfTask(task.getTask_id()));
			}
		}
		// 获取其他列表
		for (Course course : courseList) {
			List<Task> temp = courseService.getOtherBycid(course.getCourse_id());
			if (temp.size() > 3) {
				List<Task> taskList = new ArrayList<>();
				taskList.addAll(temp.subList(0, 3));
				course.setOtherList(taskList);
			} else
				course.setOtherList(temp);
		}
		Course course = new Course();
		request.setAttribute("role", userService.w_Role(user_id));
		request.setAttribute("user", userService.findUserById(user_id));
		request.setAttribute("user_id", user_id);
		request.setAttribute("courseList", courseList);
		return "jsp/activities";

	}

	@RequestMapping(value = "/toCDetail/{course_id}")
	private String toCDetail(HttpServletRequest request, @PathVariable String course_id) {
		Course course = courseService.secCourseByid(course_id);
		request.setAttribute("taskList", courseService.getTaskBycid(course_id));
		request.setAttribute("testList", courseService.getTestBycid(course_id));
		request.setAttribute("otherList", courseService.getOtherBycid(course_id));
		request.setAttribute("resourceList", courseService.getResourceBycid(course_id));
		request.setAttribute("course", course);

		List<Course> temp = courseService.findCByuserid(course.getCreate_user());
		List<Course> courseList = new ArrayList<>();
		if (temp.size() > 3) {
			for (int i = 0; i < 3; ++i)
				courseList.add(temp.get(i));
		} else {
			for (int i = 0; i < temp.size(); ++i) {
				courseList.add(temp.get(i));
			}
		}

		request.setAttribute("Cuser", userService.findUserById(course.getCreate_user()));
		courseList.remove(course);
		List<User> member = new ArrayList<>();
		List<String> userid = new ArrayList<>();
		member = courseService.getMember(course_id);
		for (User user : member) {
			userid.add(user.getUser_id());
		}
		request.setAttribute("ids", userid);
		request.setAttribute("courseList", courseList);
		return "jsp/courseDetail";
	}

	/**
	 * 跳转到添加任务页面
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/toAddTask/{course_id}")
	private String toAddTask(HttpServletRequest request, @PathVariable String course_id) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		if (user == null) {
			request.setAttribute("msg", "请先登录");
			return "jsp/user/login";
		}
		request.setAttribute("username", user.getUser_name());
		request.setAttribute("course_id", course_id);
		request.setAttribute("course", courseService.secCourseByid(course_id));
		return "jsp/addTask";

	}

	@RequestMapping(value = "/Pictureshows")
	public ResponseEntity<byte[]> Pictureshow(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String user_id = (String) session.getAttribute("user_id");
		User user = userService.findUserById(user_id);
		String path = user.getFace();
		byte[] bytes = getByte.getByte(new File(path));
		HttpHeaders headers = new HttpHeaders();
		try {
			headers.setContentType(MediaType.IMAGE_PNG);
			headers.setContentDispositionFormData("attachment", new String("face".getBytes("GBK"), "ISO8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<byte[]>(bytes, headers, HttpStatus.OK);
	}

	/**
	 * 查询系部
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/deptype")
	public String deptype(HttpServletRequest request, HttpServletResponse rsp) throws IOException {
		List<Depart> departList = new ArrayList<>();
		departList = courseService.getdepart();
		PrintWriter out = rsp.getWriter();
		out.print(com.alibaba.fastjson.JSON.toJSONString(departList));
		return null;
	}

	/**
	 * 加载图片
	 * 
	 * @param req
	 * @param resp
	 * @param id
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping(value = "/loadImage/{id}")
	public void loadImage(HttpServletRequest req, HttpServletResponse resp, @PathVariable String id) {
		try {
			String path = roleUtil.getPage("path");
			String img = courseService.getImgById(id);
			if (img == null)
				img = userService.getImgById(id);
			FileInputStream inputFile = new FileInputStream(path + img);
			int i = inputFile.available();
			byte data[] = new byte[i];
			inputFile.read(data);
			OutputStream toClient = resp.getOutputStream(); // 得到向客户端输出二进制数据的对象，获取输出流对象
			toClient.write(data); // 输出数据

			toClient.flush();
			toClient.close();
			inputFile.close();

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();

		}

	}

	@RequestMapping(value = "/deleteAcc/{acc_id}/{task_id}")
	public String deleteAcc(HttpServletRequest request, @PathVariable String acc_id, @PathVariable String task_id) {
		courseService.deleteAcc(acc_id);
		return showTask(request, task_id);
	}

}
