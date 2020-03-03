package cn.edu.tit.pager;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public class PagerBean<T> {
	private int pc;//当前页码
	private int tr;//总记录数
	private int ps;//每页记录数
	private List<T> BeanList;//页面数据 BeanList
	private String url;//第一次访问的servlet路径（request.getRequestURL())及其查询参数（request.getQueryString()按分类，作者。。）
	
	/*
	 * 计算总页数 
	 */
	public int getTp(){
		int tp = tr/ps;
		if(tr%ps!=0){
			tp++;
		}
		return tp;
	}
	/**
	 * 获得当前数据库查询偏移量
	 * @param pageSize
	 * 每页记录数
	 * @param currentPage
	 * 当前页数
	 * @return
	 */
	public int getCurrentPageOffset(int pageSize,int currentPage){
		return pageSize * (currentPage - 1);
	}
	
	public int getPc() {
		return pc;
	}
	public void setPc(int pc) {
		this.pc = pc;
	}
	public int getTr() {
		return tr;
	}
	public void setTr(int tr) {
		this.tr = tr;
	}
	public int getPs() {
		return ps;
	}
	public void setPs(int ps) {
		this.ps = ps;
	}
	public List<T> getBeanList() {
		return BeanList;
	}
	public void setBeanList(List<T> beanList) {
		BeanList = beanList;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
}
