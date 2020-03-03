package cn.edu.tit.user.Iservice;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

import cn.edu.tit.user.bean.User;

@Service
public interface IUserService {

	/**
	 * 用户注册
	 * 
	 * @param user
	 */
	public void signUp(User user);

	/**
	 * 用户登录
	 * 
	 * @param username
	 *            用户名
	 * @param password
	 *            密码
	 * @return
	 */
	public Map<String, Object> userSignIn(String user_id, String password);

	/**
	 * 用户注册
	 * 
	 * @param user
	 *            用户信息
	 */
	public Boolean userSignUP(User user);

	/**
	 * 导入用户信息
	 * 
	 * @param wb
	 * @param fileName
	 * @return
	 * @throws Exception
	 */
	public List<Integer> importInfo(Workbook wb, String fileName, String user_id1) throws Exception;

	/**
	 * 根据id查询用户
	 * 
	 * @param suer_id
	 * @return
	 */
	public User findUserById(String user_id);

	/**
	 * 查询用户全部信息（不包含密码）
	 */
	public List<User> findAllUser();

	/**
	 * 导出用户全部信息（不包含密码）
	 * 
	 * @return
	 */
	public File exportUser();

	/**
	 * 获取所有的用户id
	 * 
	 * @return
	 */
	public List<String> findUserId();

	public User login(String username, String password);

	/**
	 * 判断角色
	 * 
	 * @return
	 */
	public boolean w_Role(String user_id);

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
