package com.event;

public class EventDTO {
	private int listNum, eventNum, eventHitcount;
	
	private String userId, eventProcess, eventSubject,
	eventContent, eventCreated, saveFilename, originalFilename, eventEnd;
	
	public String getEventEnd() {
		return eventEnd;
	}
	public void setEventEnd(String eventEnd) {
		this.eventEnd = eventEnd;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getEventNum() {
		return eventNum;
	}
	public void setEventNum(int eventNum) {
		this.eventNum = eventNum;
	}
	public int getEventHitcount() {
		return eventHitcount;
	}
	public void setEventHitcount(int eventHitcount) {
		this.eventHitcount = eventHitcount;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getEventProcess() {
		return eventProcess;
	}
	public void setEventProcess(String eventProcess) {
		this.eventProcess = eventProcess;
	}
	public String getEventSubject() {
		return eventSubject;
	}
	public void setEventSubject(String eventSubject) {
		this.eventSubject = eventSubject;
	}
	public String getEventContent() {
		return eventContent;
	}
	public void setEventContent(String eventContent) {
		this.eventContent = eventContent;
	}
	public String getEventCreated() {
		return eventCreated;
	}
	public void setEventCreated(String eventCreated) {
		this.eventCreated = eventCreated;
	}
	public String getSaveFilename() {
		return saveFilename;
	}
	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
	}
	public String getOriginalFilename() {
		return originalFilename;
	}
	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

}
