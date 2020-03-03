package cn.edu.tit.jsonGet;

import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.edu.tit.course.Iservice.ICourseService;
import cn.edu.tit.course.bean.Course;
import cn.edu.tit.course.bean.Depart;
import cn.edu.tit.course.bean.Task;
import cn.edu.tit.user.Iservice.IUserService;
import cn.edu.tit.user.bean.User;
import cn.edu.tit.util.RoleUtil;

@Controller
@RequestMapping("/json")
public class Implements {
	@Autowired
	private ICourseService courseService;
	@Autowired
	private IUserService userService;
	@Autowired
	private RoleUtil roleUtil;

	/**
	 * 登陆
	 * 
	 * @param user_id
	 * @param password
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	@ResponseBody
	public User course(HttpServletRequest request) {
		String user_id = (String) request.getParameter("id");
		String password = (String) request.getParameter("password");
		User user = userService.login(user_id, password);
		if (user == null)
			return null;
		return user;
	}

	@RequestMapping(value = "/joinCourse/{user_id}/{verify}", method = RequestMethod.GET)
	@ResponseBody
	public boolean courses(@PathVariable String user_id, @PathVariable String verify) {
		Boolean isJoin = false;
		isJoin = courseService.joinCourse(verify, user_id);
		return isJoin;
	}

	@RequestMapping(value = "/course", method = RequestMethod.GET)
	@ResponseBody
	public List<Course> courses() {
		List<Course> courses = courseService.findallCourse();
		return courses;
	}

	@RequestMapping(value = "/user", method = RequestMethod.GET)
	@ResponseBody
	public List<User> GetUser() {
		List<User> users = userService.findAllUser();
		return users;
	}

	@RequestMapping(value = "/dep_course/{depart}", method = RequestMethod.GET)
	@ResponseBody
	public List<Course> GetDepCourse(@PathVariable int depart) {
		List<Course> courses = new ArrayList<>();
		try {
			courses = courseService.findCByDe(depart);
		} catch (Exception e) {
			return null;
		}
		return courses;
	}

	@RequestMapping(value = "/user_Course/{id}", method = RequestMethod.GET)
	@ResponseBody
	public List<Course> GetDepCourse(@PathVariable String id) {
		// List<Course> courses = courseService.findCByuserid(id);
		List<Course> courseList, courseList_temp, courses;
		courseList = courseService.findJoinCBySUser_id(id);
		courseList_temp = courseService.findJoinCByTUser_id(id);
		courses = new ArrayList<Course>(courseList_temp);
		try {
			for (Course course1 : courseList) {
				courses.add(courseService.secCourseByid(course1.getCourse_id()));

				for (Course course2 : courseList_temp) {
					if (!course2.getCourse_id().equals(course1.getCourse_id())) {
						courses.add(courseService.secCourseByid(course2.getCourse_id()));
					}
				}
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return courses;
	}

	@RequestMapping(value = "/course/{course_id}", method = RequestMethod.GET)
	@ResponseBody
	public Course course(@PathVariable String course_id) {
		List<Task> tasks = courseService.getTaskBycid(course_id);
		List<Task> tests = courseService.getTestBycid(course_id);
		List<Task> resources = courseService.getResourceBycid(course_id);
		Course course = courseService.secCourseByid(course_id);
		course.setTaskList(tasks);
		course.setTestList(tests);
		course.setResourceList(resources);
		return course;
	}

	/**
	 * 根据任务id查找提交者
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/homework", method = RequestMethod.GET)
	@ResponseBody
	public List<Task> Homework_user(HttpServletRequest request) {
		String task_id = request.getParameter("id");
		List<Task> upload_task = courseService.secUpStuTask(task_id);
		if (upload_task == null)
			upload_task = courseService.secUpStuTest(task_id);
		return upload_task;
	}

	/**
	 * 获取系部对应关系
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/depart", method = RequestMethod.GET)
	@ResponseBody
	public List<Depart> GetDepart(HttpServletRequest request) {
		String depart = request.getParameter("depart");
		List<Depart> departs = courseService.getdepart();
		return departs;
	}

	/**
	 * 返回学生所有作业
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/Getask", method = RequestMethod.GET)
	@ResponseBody
	public List<Task> SeaWork(HttpServletRequest request) {
		String id = request.getParameter("id");
		List<Task> tasks = courseService.secUpStuTask(id);
		if (tasks.size() == 0) {
			tasks = courseService.secUpStuTest(id);
		}
		return tasks;
	}

	/**
	 * 返回学生一作业
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/Getask_Only", method = RequestMethod.GET)
	@ResponseBody
	public Task SeaWork_Only(HttpServletRequest request) {
		String id = request.getParameter("id");
		String task_id = request.getParameter("task_id");

		List<Task> tasks = courseService.secUpStuTask(task_id);
		if (tasks.size() == 0) {
			tasks = courseService.secUpStuTest(task_id);
		}

		for (Task task : tasks) {
			if (task.getUploader().equals(id))
				return task;
		}
		return null;
	}

	/**
	 * 创建课程
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/CreateCourse", method = RequestMethod.GET)
	@ResponseBody
	public boolean CreateCourse(HttpServletRequest request) {

		String user_id = (String) request.getParameter("user");
		String course_id = user_id + "_" + System.currentTimeMillis();
		String term = "";
		String name = "";
		String clazz = "";
		String pro = null;
		String detail = "";
		String plan = "";
		try {
			term = new String(request.getParameter("term").getBytes("iso8859-1"), "utf-8");
			name = new String(request.getParameter("name").getBytes("iso8859-1"), "utf-8");
			clazz = new String(request.getParameter("clazz").getBytes("iso8859-1"), "utf-8");
			detail = new String(request.getParameter("detail").getBytes("iso8859-1"), "utf-8");
			plan = new String(request.getParameter("plan").getBytes("iso8859-1"), "utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		// String pro = request.getParameter("pro");
		int label = Integer.parseInt(request.getParameter("label"));
		int course_flag = 1;
		String invitation_code = UUID.randomUUID().toString().replace("-", "").toUpperCase().substring(0, 6);
		String user_name = userService.findUserById(user_id).getUser_name();

		Course course = new Course(course_id, name, label, null, detail, null, pro, 1, invitation_code, user_id,
				user_name, clazz, plan, term);
		try {
			courseService.createCourse(course);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * 创建活动
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/CreateAct", method = RequestMethod.GET)
	@ResponseBody
	public boolean CreateAct(HttpServletRequest request) {
		User user = userService.findUserById(request.getParameter("user"));
		Course course = courseService.secCourseByid(request.getParameter("course"));

		String task_id = course.getCourse_id() + System.currentTimeMillis();
		String name = "";
		String task_detail = "";
		String label = "";
		String delete_time = "";
		try {
			delete_time = new String(request.getParameter("delete_time").getBytes("iso8859-1"), "utf-8");
			task_detail = new String(request.getParameter("detail").getBytes("iso8859-1"), "utf-8");
			name = new String(request.getParameter("name").getBytes("iso8859-1"), "utf-8");
			label = new String(request.getParameter("label").getBytes("iso8859-1"), "utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}

		Task task = new Task(task_id, name, course.getCourse_id(), task_detail, "教师评价", user.getUser_id(),
				user.getUser_id());
		task.setDelete_time(delete_time);
		try {
			if ("实验".equals(label))
				courseService.addTest(task);
			else if ("作业".equals(label))
				courseService.addTask(task);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * 获取加入课程的成员
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getMember_C", method = RequestMethod.GET)
	@ResponseBody
	public List<User> GetMember_C(HttpServletRequest request) {
		String id = request.getParameter("id");
		List<User> user_temp = courseService.getMember(id);
		List<User> users = new ArrayList<>();
		for (User user : user_temp) {
			users.add(userService.findUserById(user.getUser_id()));
		}
		return users;
	}

	/**
	 * 获取完成任务的成员
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/getMember_T", method = RequestMethod.GET)
	@ResponseBody
	public List<User> GetMember_T(HttpServletRequest request) {
		String id = request.getParameter("id");
		List<Task> user_temp = courseService.secUpStuTask(id);
		List<User> users = new ArrayList<>();
		for (Task task : user_temp) {
			users.add(userService.findUserById(task.getUploader()));
		}
		return users;
	}

	/**
	 * 评分
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/setGrade", method = RequestMethod.GET)
	@ResponseBody
	public boolean SetGrade(HttpServletRequest request) {
		int grade = 0;
		String task_id = request.getParameter("task_id");
		String user_id = request.getParameter("user_id");
		if (!request.getParameter("grade").equals("")) {
			grade = Integer.parseInt(request.getParameter("grade"));
		} else {
			grade = 0;
		}
		courseService.setgrade(grade, task_id, user_id);
		return true;
	}

	/**
	 * 提交作业
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/UpHomework", method = RequestMethod.GET)
	@ResponseBody
	public boolean UpHomework(HttpServletRequest request) {
		String task_id = request.getParameter("task_id");
		String user_id = request.getParameter("user_id");
		String detail = "";
		try {
			detail = new String(request.getParameter("detail").getBytes("iso8859-1"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String teacher = courseService.secTaskByid(task_id).getCreate_user();

		// Task task = new Task(task_id, user_id, detail, teacher);
		Task task = new Task(task_id, courseService.secTaskByid(task_id).getTask_name(),
				courseService.secTaskByid(task_id).getCourse_id(), detail, null, null, user_id);
		task.setUploader(user_id);
		try {
			courseService.updateUpTask(task);
		} catch (Exception e1) {
			try {
				System.out.println("e1:");
				e1.printStackTrace();
				courseService.uploadTask(task);
			} catch (Exception e2) {
				System.out.println("e2");
				e2.printStackTrace();
				return false;
			}

		}
		return true;
	}

	/**
	 * 修改信息
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/ChangeInfo", method = RequestMethod.GET)
	@ResponseBody
	public boolean ChangeInfo(HttpServletRequest request) {
		String id = request.getParameter("user_id");
		String password = request.getParameter("password");
		String mobile = request.getParameter("mobile");
		String detail = request.getParameter("detail");
		User user = userService.findUserById(id);
		user.setPassword(password);
		user.setMobile(mobile);
		user.setDetail(detail);

		try {
			userService.ChangeInfo(user);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	/**
	 * 加载图片
	 * 
	 * @param resp
	 * @param id
	 */
	@RequestMapping(value = "/loadimg/{id}", method = RequestMethod.GET)
	@ResponseBody
	public void loadImage(HttpServletResponse resp, @PathVariable String id) {
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

}
