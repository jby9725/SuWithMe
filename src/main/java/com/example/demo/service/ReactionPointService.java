package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.ReactionPointRepository;
import com.example.demo.vo.ResultData;

@Service
public class ReactionPointService {

	@Autowired
	private ArticleService articleService;

	@Autowired
	private ReactionPointRepository reactionPointRepository;

	public ReactionPointService(ReactionPointRepository reactionPointRepository) {
		this.reactionPointRepository = reactionPointRepository;
	}

	public ResultData usersReaction(int loginedMemberId, String relTypeCode, int relId) {

		if (loginedMemberId == 0) {
			return ResultData.from("F-L", "로그인 해야합니다.");
		}

		int sumReactionPointByMemberId = reactionPointRepository.getSumReactionPoint(loginedMemberId, relTypeCode,
				relId);

		if (sumReactionPointByMemberId != 0) {
			return ResultData.from("F-1", "추천이 불가능합니다.", "sumReactionPointByMemberId", sumReactionPointByMemberId);
		}

		return ResultData.from("S-1", "추천이 가능합니다.", "sumReactionPointByMemberId", sumReactionPointByMemberId);
	}

	public ResultData addGoodReactionPoint(int loginedMemberId, String relTypeCode, int relId) {

		int affectedRow = reactionPointRepository.addGoodReactionPoint(loginedMemberId, relTypeCode, relId);

		if (affectedRow != 1) {
			return ResultData.from("F-1", "좋아요가 실패하였습니다.");
		}

		switch (relTypeCode) {
		case "article":
			articleService.increaseGoodReactionPoint(relId);
			break;
		}

		return ResultData.from("S-1", "좋아요가 등록되었습니다.");
	}

	public ResultData addBadReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		int affectedRow = reactionPointRepository.addBadReactionPoint(loginedMemberId, relTypeCode, relId);

		if (affectedRow != 1) {
			return ResultData.from("F-1", "싫어요가 실패하였습니다.");
		}

		switch (relTypeCode) {
		case "article":
			articleService.increaseBadReactionPoint(relId);
			break;
		}

		return ResultData.from("S-1", "싫어요가 등록되었습니다.");
	}

	public ResultData deleteGoodReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		reactionPointRepository.deleteReactionPoint(loginedMemberId, relTypeCode, relId);

		switch (relTypeCode) {
		case "article":
			articleService.decreaseGoodReactionPoint(relId);
			break;
		}
		return ResultData.from("S-1", "좋아요가 취소되었습니다.");

	}

	public ResultData deleteBadReactionPoint(int loginedMemberId, String relTypeCode, int relId) {
		reactionPointRepository.deleteReactionPoint(loginedMemberId, relTypeCode, relId);

		switch (relTypeCode) {
		case "article":
			articleService.decreaseBadReactionPoint(relId);
			break;
		}
		return ResultData.from("S-1", "싫어요가 취소되었습니다.");
	}

	public boolean isAlreadyAddGoodRp(int memberId, int relId, String relTypeCode) {
		int getPointTypeCodeByMemberId = reactionPointRepository.getSumReactionPoint(memberId, relTypeCode, relId);

		if (getPointTypeCodeByMemberId > 0) {
			return true;
		}

		return false;
	}

	public boolean isAlreadyAddBadRp(int memberId, int relId, String relTypeCode) {
		int getPointTypeCodeByMemberId = reactionPointRepository.getSumReactionPoint(memberId, relTypeCode, relId);

		if (getPointTypeCodeByMemberId < 0) {
			return true;
		}

		return false;
	}

}