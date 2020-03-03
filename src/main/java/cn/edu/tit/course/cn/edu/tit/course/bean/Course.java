package cn.edu.tit.course.bean;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Repository;

import cn.edu.tit.user.bean.User;

@Repository
public class Course {

	private String course_id; // 课程id (发布者id_时间戳)
	private String course_name; // 课程名
	private int course_label; // 课程标签
	private String publisher;// 发布者名字
	private String clazz; // 班级
	private String plan; // 授课计划
	private String course_img; // 课程图片
	private String course_notes; // 课程备注（简介）

	private List<Task> taskList; // 课程任务列表
	private List<Task> testList; // 课程实验列表
	private List<Task> resourceList; // 课程资源列表
	private List<Task> otherList; // 课程其他列表
	private List<User> memberList; // 成员列表

	private String college; // 所属学校
	private String application_pro; // 适合专业
	private int course_flag; // 课程状态标志位（1：开始，2：截止）
	private String invitation_code; // 邀请码
	private String schoolTerm;// 学期
	private Boolean delete_flg;// 是否删除
	private String create_user;// 创建者
	private Date create_time;// 创建时间
	private String update_user;// 更新者
	private Date update_time;// 更新时间

	// setter-getter

	public String getCourse_id() {
		return course_id;
	}

	public List<User> getMemberList() {
		return memberList;
	}

	public void setMemberList(List<User> memberList) {
		this.memberList = memberList;
	}

	public List<Task> getTestList() {
		return testList;
	}

	public void setTestList(List<Task> testList) {
		this.testList = testList;
	}

	public List<Task> getResourceList() {
		return resourceList;
	}

	public void setResourceList(List<Task> resourceList) {
		this.resourceList = resourceList;
	}

	public List<Task> getOtherList() {
		return otherList;
	}

	public void setOtherList(List<Task> otherList) {
		this.otherList = otherList;
	}

	public String getClazz() {
		return clazz;
	}

	public void setClazz(String clazz) {
		this.clazz = clazz;
	}

	public String getPlan() {
		return plan;
	}

	public void setPlan(String plan) {
		this.plan = plan;
	}

	public List<Task> getTaskList() {
		return taskList;
	}

	public void setTaskList(List<Task> taskList) {
		this.taskList = taskList;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getSchoolTerm() {
		return schoolTerm;
	}

	public void setSchoolTerm(String schoolTerm) {
		this.schoolTerm = schoolTerm;
	}

	public void setCourse_label(int course_label) {
		this.course_label = course_label;
	}

	public String getCollege() {
		return college;
	}

	public void setCollege(String college) {
		this.college = college;
	}

	public String getInvitation_code() {
		return invitation_code;
	}

	public void setInvitation_code(String invitation_code) {
		this.invitation_code = invitation_code;
	}

	public int getCourse_flag() {
		return course_flag;
	}

	public void setCourse_flag(int course_flag) {
		this.course_flag = course_flag;
	}

	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}

	public String getCourse_name() {
		return course_name;
	}

	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}

	public int getCourse_label() {
		return course_label;
	}

	public void setCourse_lable(int course_lable) {
		this.course_label = course_lable;
	}

	public String getCourse_img() {
		return course_img;
	}

	public void setCourse_img(String course_img) {
		this.course_img = course_img;
	}

	public String getCourse_notes() {
		return course_notes;
	}

	public void setCourse_notes(String course_notes) {
		this.course_notes = course_notes;
	}

	public String getApplication_pro() {
		return application_pro;
	}

	public void setApplication_pro(String application_pro) {
		this.application_pro = application_pro;
	}

	public Boolean getDelete_flg() {
		return delete_flg;
	}

	public void setDelete_flg(Boolean delete_flg) {
		this.delete_flg = delete_flg;
	}

	public String getCreate_user() {
		return create_user;
	}

	public void setCreate_user(String create_user) {
		this.create_user = create_user;
	}

	public String getUpdate_user() {
		return update_user;
	}

	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public Date getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(Date update_time) {
		this.update_time = update_time;
	}

	public Course(String course_id, String course_name, int course_label, String course_img, String course_notes,
			String college, String application_pro, int course_flag, String invitation_code, String create_user,
			String publisher, String clazz, String plan, String term) {
		super();
		this.course_id = course_id;
		this.course_name = course_name;
		this.course_label = course_label;
		this.course_img = course_img;
		this.course_notes = course_notes;
		this.college = college;
		this.application_pro = application_pro;
		this.course_flag = course_flag;
		this.invitation_code = invitation_code;
		this.create_user = create_user;
		this.publisher = publisher;
		this.clazz = clazz;
		this.plan = plan;
		this.schoolTerm = term;
	}

	public Course() {
	}
}
