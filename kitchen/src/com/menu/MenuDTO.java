package com.menu;

public class MenuDTO {
	int menunum, menuprice;
	String menuname, menucontent, savefilename, origrnalfilename;
	

	public int getMenunum() {
		return menunum;
	}
	public void setMenunum(int menunum) {
		this.menunum = menunum;
	}
	public int getMenuprice() {
		return menuprice;
	}
	public void setMenuprice(int menuprice) {
		this.menuprice = menuprice;
	}
	public String getMenuname() {
		return menuname;
	}
	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}
	public String getMenucontent() {
		return menucontent;
	}
	public void setMenucountent(String menucountent) {
		this.menucontent = menucountent;
	}
	public String getSavefilename() {
		return savefilename;
	}
	public void setSavefilename(String savefilename) {
		this.savefilename = savefilename;
	}
	public String getOrigrnalfilename() {
		return origrnalfilename;
	}
	public void setOrigrnalfilename(String origrnalfilename) {
		this.origrnalfilename = origrnalfilename;
	}

}
