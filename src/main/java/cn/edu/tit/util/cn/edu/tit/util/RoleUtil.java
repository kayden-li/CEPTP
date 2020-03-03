package cn.edu.tit.util;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.springframework.stereotype.Repository;

@Repository
public class RoleUtil {
	
	private ClassLoader classLoader = RoleUtil.class.getClassLoader();  
	
	/**
	 * 从properties文件获取页面
	 * @param key
	 * 要获取的页面,properties的键
	 * @return
	 */
	public String getPage(String key){
		Properties pro = new Properties();
		String page = ""; 
		InputStream bfs;
		try {
			bfs = new BufferedInputStream(classLoader.getResourceAsStream("page.properties"));
			pro.load(bfs);
			page = pro.getProperty(key);
			bfs.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return page;
	}

	/**
	 * 将传入的数字作为脚标获得26个英文字母中对应的字母
	 * 此方法用于判断当前角色属于其父角色的第几个孩子以获取其相应id
	 * @param num
	 * 查出的兄弟角色数量
	 * @return
	 * 对应的英文字母
	 */
	public char getLetterByNum(int num){
		char name =' ';
		switch (num) {
		case 0:{
			name = 'A';
			break;
		}
		case 1:{
			name = 'B';
			break;
		}
		case 2:{
			name = 'C';
			break;
		}
		case 3:{
			name = 'D';
			break;
		}
		case 4:{
			name = 'E';
			break;
		}
		case 5:{
			name = 'F';
			break;
		}
		case 6:{
			name = 'G';
			break;
		}
		case 7:{
			name = 'H';
			break;
		}
		case 8:{
			name = 'I';
			break;
		}
		case 9:{
			name = 'J';
			break;
		}
		case 10:{
			name = 'K';
			break;
		}
		case 11:{
			name = 'L';
			break;
		}
		case 12:{
			name = 'M';
			break;
		}
		case 13:{
			name = 'N';
			break;
		}
		case 14:{
			name = 'O';
			break;
		}
		case 15:{
			name = 'P';
			break;
		}
		case 16:{
			name = 'Q';
			break;
		}
		case 17:{
			name = 'R';
			break;
		}
		case 18:{
			name = 'S';
			break;
		}
		case 19:{
			name = 'T';
			break;
		}
		case 20:{
			name = 'U';
			break;
		}
		case 21:{
			name = 'V';
			break;
		}
		case 22:{
			name = 'W';
			break;
		}
		case 23:{
			name = 'X';
			break;
		}
		case 24:{
			name = 'Y';
			break;
		}
		case 25:{
			name = 'Z';
			break;
		}
		default:
			break;
		}
		return name;
	}

}
