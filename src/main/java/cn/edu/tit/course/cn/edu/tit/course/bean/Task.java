package cn.edu.tit.course.bean;

import java.util.List;

public class Task {
	// 任务题目
	private String task_id; // 任务id (课程id_时间戳)
	private String task_type;
	private String task_name; // 任务名
	private String course_id; // 所属课程id
	private String task_details; // 发布任务描述
	private List<Accessory> pubAccs; // 发布附件
	private String evaluate_kind; // 评价类型（老师评价，组员评价）
	private String evaluate_id; // 评价者id

	// 任务的提交内容
	private String uploader; // 任务提交者id
	private String uploadTask_details; // 提交内容描述
	private List<Accessory> uploadAccs; // 提交附件
	private String grade; // 成绩

	private int status; // 任务状态（1：发布，2：评价：3：结束）

	private Boolean delete_flg;// 是否删除
	private String create_user;// 任务创建者
	private String create_time;// 创建时间
	private String update_user;// 更新者
	private String update_time;// 更新时间
	private String delete_time;// 结束时间
	private int download_num;// 下载人数
	// 任务的提交人数
	private int num;

	// setter-getter

	public int getNum() {
		return num;
	}

	public String getDelete_time() {
		return delete_time;
	}

	public void setTask_type(String task_type) {
		this.task_type = task_type;
	}

	public String getTask_type() {
		return task_type;
	}

	public String getTask_id() {
		return task_id;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getEvaluate_kind() {
		return evaluate_kind;
	}

	public void setEvaluate_kind(String evaluate_kind) {
		this.evaluate_kind = evaluate_kind;
	}

	public String getEvaluate_id() {
		return evaluate_id;
	}

	public void setEvaluate_id(String evaluate_id) {
		this.evaluate_id = evaluate_id;
	}

	public void setDelete_time(String delete_time) {
		this.delete_time = delete_time;
	}

	public List<Accessory> getPubAccs() {
		return pubAccs;
	}

	public void setPubAccs(List<Accessory> pubAccs) {
		this.pubAccs = pubAccs;
	}

	public List<Accessory> getUploadAccs() {
		return uploadAccs;
	}

	public void setUploadAccs(List<Accessory> uploadAccs) {
		this.uploadAccs = uploadAccs;
	}

	public String getUploader() {
		return uploader;
	}

	public void setUploader(String uploader) {
		this.uploader = uploader;
	}

	public String getUploadTask_details() {
		return uploadTask_details;
	}

	public void setUploadTask_details(String uploadTask_details) {
		this.uploadTask_details = uploadTask_details;
	}

	public String getGrade() {
		return grade;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public void setTask_id(String task_id) {
		this.task_id = task_id;
	}

	public String getTask_name() {
		return task_name;
	}

	public void setTask_name(String task_name) {
		this.task_name = task_name;
	}

	public String getCourse_id() {
		return course_id;
	}

	public void setCourse_id(String course_id) {
		this.course_id = course_id;
	}

	public String getTask_details() {
		return task_details;
	}

	public void setTask_details(String task_details) {
		this.task_details = task_details;
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

	public String getCreate_time() {
		return create_time;
	}

	public void setCreate_time(String create_time) {
		this.create_time = create_time;
	}

	public String getUpdate_user() {
		return update_user;
	}

	public void setUpdate_user(String update_user) {
		this.update_user = update_user;
	}

	public String getUpdate_time() {
		return update_time;
	}

	public void setUpdate_time(String update_time) {
		this.update_time = update_time;
	}

	public Task(String task_id, String task_name, String course_id, String task_details, String evaluate_kind,
			String evaluate_id, String create_user) {
		super();
		this.task_id = task_id;
		this.task_name = task_name;
		this.course_id = course_id;
		this.task_details = task_details;
		this.uploadTask_details = task_details;
		this.evaluate_kind = evaluate_kind;
		this.evaluate_id = evaluate_id;
		this.create_user = create_user;

	}

	public Task() {
	}

	public Task(String task_id, String uploader, String uploadTask_details, String create_user) {
		super();
		this.task_id = task_id;
		this.uploader = uploader;
		this.uploadTask_details = uploadTask_details;
		this.create_user = create_user;
	}

	public int getDownload_num() {
		return download_num;
	}

	public void setDownload_num(int download_num) {
		this.download_num = download_num;
	};

}
