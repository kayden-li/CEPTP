package cn.edu.tit.course.Iservice.serviceImp;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.edu.tit.course.Idao.ICourseDao;
import cn.edu.tit.course.Iservice.ICourseService;
import cn.edu.tit.course.bean.Accessory;
import cn.edu.tit.course.bean.Course;
import cn.edu.tit.course.bean.Depart;
import cn.edu.tit.course.bean.Task;
import cn.edu.tit.pager.PageConstents;
import cn.edu.tit.pager.PagerBean;
import cn.edu.tit.user.bean.User;
import cn.edu.tit.util.StatusCode;

@Service
public class CourseSerivceImp implements ICourseService {

	@Autowired
	private ICourseDao courseDao;

	@Transactional
	@Override
	public void createCourse(Course course) {
		// 接收课程信息将课程信息存入数据库
		courseDao.addCourse(course);
	}

	@Transactional
	@Override
	public Boolean joinCourse(String verify, String user_id) {
		try {
			// 通过课程id查询邀请码
			Course course = courseDao.getverify(verify);
			String invitationCode = course.getInvitation_code();
			String create_user = course.getCreate_user();
			// 校验邀请码
			if (invitationCode.equals(verify) && invitationCode != null) {
				// 正确将申请者加入
				courseDao.joinCourse(user_id, course.getCourse_id(), create_user);
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}

	@Transactional
	@Override
	public String addTask(Task task) {
		try {
			// 将为课程添加的任务加入数据库
			courseDao.addTask(task);
			// 获取附件添加
			List<Accessory> accessoryList = new ArrayList<Accessory>();
			accessoryList = task.getPubAccs();
			if (null != accessoryList && accessoryList.size() != 0) {
				for (Accessory acc : accessoryList) {
					// 附件信息存库
					courseDao.addAcc(acc);
				}
			}
			return StatusCode.SUCCESS_CREATE;
		} catch (Exception e) {
			e.printStackTrace();
			return StatusCode.EXECUTE_ERROR;
		}
	}

	@Transactional
	@Override
	public void uploadTask(Task task) {
		try {
			// 通过id获取任务创建者id
			String create_user = courseDao.getTaskCreater(task.getTask_id());
			task.setCreate_user(create_user);
			// 将提交的内容存库
			courseDao.uploadTask(task);
			List<Accessory> accessoryList = new ArrayList<Accessory>();
			accessoryList = task.getPubAccs();
			if (null != accessoryList && accessoryList.size() != 0) {
				for (Accessory acc : accessoryList) {
					// 附件存库
					courseDao.addAcc(acc);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Transactional
	@Override
	public Task secTaskBycon(String kind, String condition) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Task secTaskByid(String task_id) {
		Task task = courseDao.findTextByid(task_id);
		return task;
	}

	@Override
	public Task secTestByid(String task_id) {
		Task task = courseDao.findTestByid(task_id);
		return task;
	}

	@Override
	public Task secOtherByid(String task_id) {
		Task task = courseDao.findOtherByid(task_id);
		return task;
	}

	@Override
	public Task secResByid(String task_id) {
		Task task = courseDao.findResByid(task_id);
		return task;
	}

	@Override
	public String getaccPath(String acc_id) {
		return courseDao.getAccPath(acc_id);
	}

	@Override
	public List<Accessory> getAccs(String task_id, int kind) {
		return courseDao.getAccList(task_id, kind);
	}

	@Override
	public List<Task> getUploadByid(String task_id) {
		return courseDao.getUpbyid(task_id);
	}

	@Override
	public Task getUpload(String task_id, String user_id) {
		return courseDao.getupload(task_id, user_id);
	}

	@Override
	public int getTaskStatus(String task_id) {
		return courseDao.findTaskStatus(task_id);
	}

	@Transactional
	@Override
	public void setgrade(int grade, String task_id, String user_id) {
		courseDao.updategrade(grade, task_id, user_id);
	}

	@Override
	public int getTaskGrade(String task_id, String user_id) {
		return courseDao.findTaskGrade(task_id, user_id);
	}

	@Override
	public PagerBean<Course> getCPage(int pc, String course_label) {
		// 获取总记录数
		int tr = courseDao.getCNumByLable(course_label);
		// 获得每页记录数
		int ps = PageConstents.COURSE_PAGE_SIZE;
		int begin = (pc - 1) * ps;
		int end = ps;
		List<Course> beanList = courseDao.getCByPage(course_label, begin, end);
		PagerBean<Course> pg = new PagerBean<>();
		pg.setBeanList(beanList);
		pg.setPc(pc);
		pg.setPs(ps);
		pg.setTr(tr);
		return pg;
	}

	@Override
	public Course secCourseByid(String course_id) {

		return courseDao.findcByid(course_id);
	}

	@Override
	public List<Course> findCByuserid(String user_id) {
		List<Course> courseList = new ArrayList<>();
		courseList = courseDao.findCByUserid(user_id);

		return courseList;
	}

	@Override
	public List<Course> getjoinCourse(String user_id) {
		// 通过userid查询加入课程id
		List<String> course_idList = courseDao.findJoinCourseid(user_id);
		List<Course> courseList = new ArrayList<>();
		for (String course_id : course_idList) {
			courseList.add(courseDao.findcByid(course_id));
		}
		return courseList;
	}

	@Override
	public List<Depart> getdepart() {
		// TODO Auto-generated method stub
		return courseDao.getDepart();
	}

	@Override
	public List<Course> findallCourse() {
		// TODO Auto-generated method stub
		return courseDao.findallCourse();
	}

	@Override
	public List<Course> findCByDe(int de) {
		// TODO Auto-generated method stub
		return courseDao.findCoursebyDe(de);
	}

	@Override
	public List<Course> findJoinCBySUser_id(String user_id) {
		// TODO Auto-generated method stub
		return courseDao.findJoinCBySUser_id(user_id);
	}

	@Override
	public List<Course> findJoinCByTUser_id(String user_id) {
		// TODO Auto-generated method stub
		return courseDao.findJoinCByTUser_id(user_id);
	}

	@Override
	public String getImgById(String id) {
		// TODO Auto-generated method stub
		return courseDao.getImgById(id);
	}

	@Override
	public void updateUpTask(Task task) {
		// TODO Auto-generated method stub
		courseDao.updateUpTask(task);
		List<Accessory> accessoryList = new ArrayList<Accessory>();
		accessoryList = task.getPubAccs();
		if (null != accessoryList && accessoryList.size() != 0) {
			for (Accessory acc : accessoryList) {
				// 附件存库
				courseDao.addAcc(acc);
			}
		}
	}

	@Override
	public void deleteAcc(String acc_id) {
		// TODO Auto-generated method stub
		courseDao.deleteAcc(acc_id);
	}

	@Override
	public int numOfTask(String task_id) {
		// TODO Auto-generated method stub
		return courseDao.numOfTask(task_id);
	}

	@Override
	public int numOfTest(String task_id) {
		// TODO Auto-generated method stub
		return courseDao.numOfTest(task_id);
	}

	@Override
	public void addResource(Task task) {
		// TODO Auto-generated method stub
		courseDao.addResource(task);

	}

	@Override
	public void addTest(Task task) {
		// TODO Auto-generated method stub
		courseDao.addTest(task);

	}

	@Override
	public void addOther(Task task) {
		// TODO Auto-generated method stub
		courseDao.addOther(task);

	}

	@Override
	public List<Task> getTaskBycid(String course_id) {

		return courseDao.getTaskBycid(course_id);
	}

	@Override
	public List<Task> getTestBycid(String course_id) {
		// TODO Auto-generated method stub
		return courseDao.getTestBycid(course_id);
	}

	@Override
	public List<Task> getResourceBycid(String course_id) {
		// TODO Auto-generated method stub
		return courseDao.getResourceBycid(course_id);
	}

	@Override
	public List<Task> getOtherBycid(String course_id) {
		// TODO Auto-generated method stub
		return courseDao.getOtherBycid(course_id);
	}

	@Override
	public List<User> getMember(String course_id) {
		// TODO Auto-generated method stub
		return courseDao.getMember(course_id);
	}

	@Override
	public void ChangeStatus(String id, String status, String kind) {
		// TODO Auto-generated method stub
		if (kind.equals("task"))
			courseDao.ChangeStatus_task(id, status);
		else if (kind.equals("test"))
			courseDao.ChangeStatus_test(id, status);
		else if (kind.equals("other"))
			courseDao.ChangeStatus_other(id, status);
	}

	@Override
	public int GetMember(String id) {
		// TODO Auto-generated method stub
		return courseDao.GetMember(id);
	}

	@Override
	public void addDownloadNum(String id) {
		// TODO Auto-generated method stub
		courseDao.addDownloadNum(id);
	}

	/**
	 * 根据任务id查询已提交
	 * 
	 * @param task_id
	 * @return
	 */
	@Override
	public List<Task> secUpStuTask(String task_id) {
		// TODO Auto-generated method stub
		return courseDao.secUpStuTask(task_id);
	}

	@Override
	public List<Task> secUpStuTest(String task_id) {
		// TODO Auto-generated method stub
		return courseDao.secUpStuTest(task_id);
	}

}
