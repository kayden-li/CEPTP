package cn.edu.tit.user.bean;

import java.util.Arrays;

public class OutUser {
	private String user_id;// 学号、工号
	private String user_name;// 姓名
	private String sex;// 性别
	//private String password;// 密码
	private String class_name;// 班级
	private String professional_title; //职称
	private String detail; //简介
	private byte[] face; //头像
	private String pro;// 专业
	private String qq;// QQ号
	private String mobile;// 移动电话
	private String delete_flg;//是否删除
	private String create_user;//创建者
	private String create_time;//创建时间
	private String update_user;//更新者
	private String update_time;//更新时间
	public OutUser() {
		super();
	}
	
	public OutUser(String user_id, String user_name, String class_name, String professional_title, 
			String detail, String pro, String qq, String mobile, 
			String create_user, String create_time, String update_user, String update_time) {
		super();
		this.user_id = user_id;
		this.user_name = user_name;
		this.class_name = class_name;
		this.professional_title = professional_title;
		this.detail = detail;
		this.pro = pro;
		this.qq = qq;
		this.mobile = mobile;
		this.create_user = create_user;
		this.create_time = create_time;
		this.update_user = update_user;
		this.update_time = update_time;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getClass_name() {
		return class_name;
	}

	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getProfessional_title() {
		return professional_title;
	}

	public void setProfessional_title(String professional_title) {
		this.professional_title = professional_title;
	}


	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public byte[] getFace() {
		return face;
	}

	public void setFace(byte[] face) {
		this.face = face;
	}

	public String getPro() {
		return pro;
	}

	public void setPro(String pro) {
		this.pro = pro;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}


	public String getDelete_flg() {
		return delete_flg;
	}

	public void setDelete_flg(String delete_flg) {
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

}
