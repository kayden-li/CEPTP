package cn.edu.tit.course.bean;

import java.io.File;

public class Accessory {
	
	private String accessory_id; //附件id
	private String accessory_name; //附件名
	private String task_id; //所属任务id
	private String accessory_path; //附件存放路径
	private File accessory; //附件
	private int accessory_kind; //表示附件是所属于教学者发布的任务(1)还是学习者的提交结果(2)
	
	private Boolean delete_flg;//是否删除
	private String create_user;//创建者
	private String create_time;//创建时间
	private String update_user;//更新者
	private String update_time;//更新时间
	
	
	public String getAccessory_id() {
		return accessory_id;
	}
	public void setAccessory_id(String accessory_id) {
		this.accessory_id = accessory_id;
	}
	public File getAccessory() {
		return accessory;
	}
	public void setAccessory(File accessory) {
		this.accessory = accessory;
	}
	public String getAccessory_name() {
		return accessory_name;
	}
	public void setAccessory_name(String accessory_name) {
		this.accessory_name = accessory_name;
	}
	public String getTask_id() {
		return task_id;
	}
	public void setTask_id(String task_id) {
		this.task_id = task_id;
	}
	public String getAccessory_path() {
		return accessory_path;
	}
	public void setAccessory_path(String accessory_path) {
		this.accessory_path = accessory_path;
	}
	public int getAccessory_kind() {
		return accessory_kind;
	}
	public void setAccessory_kind(int accessory_kind) {
		this.accessory_kind = accessory_kind;
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
	public Accessory(String accessory_name, String task_id, String accessory_path, int accessory_kind,
			 String create_user, String update_user) {
		super();
		this.accessory_name = accessory_name;
		this.task_id = task_id;
		this.accessory_path = accessory_path;
		this.accessory_kind = accessory_kind;
		this.create_user = create_user;
		this.update_user = update_user;
	}
	public Accessory(){}
	
}
