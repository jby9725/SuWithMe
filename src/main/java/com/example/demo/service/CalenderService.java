package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.CalenderRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Event;
import com.example.demo.vo.ResultData;

@Service
public class CalenderService {

	@Autowired
	private CalenderRepository calenderRepository;

	public CalenderService(CalenderRepository calenderRepository) {
		this.calenderRepository = calenderRepository;
	}

	public List<Event> getAllEventsByMemberId(int memberId) {
		return calenderRepository.getAllEventsBymemberId(memberId); // 모든 일정 조회
	}

	public ResultData addEvent(String title, String body, String startDate, String endDate, int userId) {
		calenderRepository.addEvent(title, body, startDate, endDate, userId);

		return ResultData.from("S-1", Ut.f("일정이 등록되었습니다"));
	}

	public ResultData markComplete(int eventId) {
		// 이벤트 조회
		Event event = calenderRepository.getEventById(eventId);
		if (event == null) {
			return ResultData.from("F-1", "해당 일정이 존재하지 않습니다.");
		}

		// 이미 완료된 일정인지 확인
		if (event.isCompleted()) {
			return ResultData.from("F-2", "이미 '오수완'으로 표시된 일정입니다.");
		}

		// 완료 상태로 업데이트
		calenderRepository.updateCompletedStatus(eventId, true);

		return ResultData.from("S-1", "일정이 '오수완'으로 표시되었습니다.");
	}

	public Event getEventById(int id) {
        return calenderRepository.getEventById(id);
    }

	public ResultData userCanDelete(int loginedMemberId, Event event) {
		if (event.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 일정에 대한 삭제 권한이 없습니다", event.getId()));
		}
		return ResultData.from("S-1", Ut.f("%d번 일정을 삭제했습니다", event.getId()));
	}

	public ResultData userCanModify(int loginedMemberId, Event event) {
		if (event.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 일정에 대한 수정 권한이 없습니다", event.getId()));
		}
		return ResultData.from("S-1", Ut.f("%d번 일정을 수정했습니다", event.getId()), "수정된 일정", event);
	}

	public void deleteEvent(int id) {
		calenderRepository.deleteEvent(id);
	}

	public void modifyEvent(int id, String title, String body) {
		calenderRepository.modifyEvent(id, title, body);
	}
	
}
