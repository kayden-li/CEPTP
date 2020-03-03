package cn.edu.tit.user.Idao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import cn.edu.tit.user.bean.User;

@Component
public interface IUserDao {

	/**
	 * 通过user_id查询用户
	 * 
	 * @param user_id
	 * @return
	 */
	public User findUserById(String user_id);

	/**
	 * 超级管理员添加用户
	 * 
	 * @param teacher
	 * @param create_user
	 * @param create_time
	 * @param update_user
	 * @param update_time
	 */
	public void importInfo(User user);

	/**
	 * 获取所有User信息
	 * 
	 * @return
	 */
	public List<User> findAllUser();

	/**
	 * 查询所有用户Id
	 * 
	 * @return
	 */
	public List<String> findUserId();

	/**
	 * 根据条件查询教师
	 * 
	 * @param staff_id
	 * @param staff_name
	 * @return 教师列表
	 */
	/*
	 * public List<Teacher> findUserByCondition(@Param("staff_id")String
	 * staff_id, @Param("role_id")String role_id);
	 */

	public User login(@Param("username") String username, @Param("password") String password);

	/**
	 * 判断角色
	 * 
	 * @return
	 */
	public String w_Role(String user_id);

	/**
	 * 加载角色头像
	 * 
	 * @param id
	 * @return
	 */
	public String getImgById(String id);

	/**
	 * 更改用户信息
	 * 
	 * @param user
	 */
	public void ChangeInfo(User user);
}
