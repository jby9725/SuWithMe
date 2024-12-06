package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.example.demo.repository.MemberRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;

@Service
public class MemberService {

	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;

	@Autowired
	private MemberRepository memberRepository;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}

	public ResultData notifyTempLoginPwByEmail(Member actor) {
		// 1. 임시 비밀번호 생성
		String tempPassword = Ut.getTempPassword(6);

		// 2. 임시 비밀번호를 회원 데이터베이스에 저장
		setTempPassword(actor, tempPassword);

		// 3. 팝업창에서 표시할 메시지 구성
		String message = "<h1>임시 비밀번호: " + tempPassword + "</h1>";
		message += "<a href=\"" + siteMainUri + "/usr/member/login\" target=\"_blank\">로그인 하러가기</a>";

		// 4. 팝업창으로 임시 비밀번호를 표시하는 메시지를 반환
		return ResultData.from("S-1", message);
	}

	private void setTempPassword(Member actor, String tempPassword) {
		memberRepository.modify(actor.getId(), Ut.sha256(tempPassword), null, null, null, null);
	}

	public ResultData<Integer> join(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {

		Member existsMember = getMemberByLoginId(loginId);

		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용중인 아이디(%s)입니다.", loginId));
		}

		existsMember = getMemberByNameAndEmail(name, email);

		if (existsMember != null) {
			return ResultData.from("F-8", Ut.f("이미 사용중인 이름(%s)과 이메일(%s)입니다.", name, email));
		}

		loginPw = Ut.sha256(loginPw);

		memberRepository.doJoin(loginId, loginPw, name, nickname, cellphoneNum, email);

		int id = memberRepository.getLastInsertId();

		return ResultData.from("S-1", "회원가입 성공", "생성된 회원 id", id);
	}

	public int getMembersCount(String authLevel, String searchKeywordTypeCode, String searchKeyword) {
		return memberRepository.getMembersCount(authLevel, searchKeywordTypeCode, searchKeyword);
	}

	public List<Member> getForPrintMembers(String authLevel, String searchKeywordTypeCode, String searchKeyword,
			int itemsInAPage, int page) {

		int limitStart = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;
		List<Member> members = memberRepository.getForPrintMembers(authLevel, searchKeywordTypeCode, searchKeyword,
				limitStart, limitTake);

		return members;
	}

	public void deleteMembers(List<Integer> memberIds) {
		for (int memberId : memberIds) {
			Member member = getMemberById(memberId);

			if (member != null) {
				deleteMember(member);
			}
		}
	}

	private void deleteMember(Member member) {
		memberRepository.deleteMember(member.getId());
	}

	public Member getMemberByNameAndEmail(String name, String email) {
		return memberRepository.getMemberByNameAndEmail(name, email);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}

	public Member getMemberByLoginIdAndEmail(String loginId, String email) {
		return memberRepository.getMemberByLoginIdAndEmail(loginId, email);
	}

	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}

	public ResultData modify(int loginedMemberId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {

		loginPw = Ut.sha256(loginPw);

		memberRepository.modify(loginedMemberId, loginPw, name, nickname, cellphoneNum, email);

		return ResultData.from("S-1", "회원정보 수정 완료");
	}

	public ResultData modifyWithoutPw(int loginedMemberId, String name, String nickname, String cellphoneNum,
			String email) {
		memberRepository.modifyWithoutPw(loginedMemberId, name, nickname, cellphoneNum, email);

		return ResultData.from("S-1", "회원정보 수정 완료");
	}

	public void updatePassword(int memberId, String encodedPassword) {
	    // 비밀번호를 데이터베이스에 업데이트
	    memberRepository.updatePassword(memberId, encodedPassword);
	}

}