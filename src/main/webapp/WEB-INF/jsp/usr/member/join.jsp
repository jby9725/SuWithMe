<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="JOIN"></c:set>
<%@ include file="../common/head_NonOption.jspf"%>

<%@ include file="../common/sidebar.jspf"%>

<!-- lodash debounce -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script>
	let validLoginId = "";
	function JoinForm__submit(form) {

		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value == 0) {
			alert('아이디를 입력해주세요');
			return;
		}
		if (form.loginId.value != validLoginId) {
			alert('사용할 수 없는 아이디입니다.');
			form.loginId.focus();
			return;
		}
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value == 0) {
			alert('비밀번호를 입력해주세요');
			return;
		}
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value == 0) {
			alert('비밀번호 확인을 입력해주세요');
			return;
		}
		if (form.loginPwConfirm.value != form.loginPw.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.focus();
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value == 0) {
			alert('이름을 입력해주세요');
			return;
		}
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value == 0) {
			alert('닉네임을 입력해주세요');
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value == 0) {
			alert('이메일을 입력해주세요');
			return;
		}
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		if (form.cellphoneNum.value == 0) {
			alert('전화번호를 입력해주세요');
			return;
		}
		submitJoinFormDone = true;
		form.submit();
	}

	function checkLoginIdDup(el) {
		$('.checkDup-msg').empty();
		const form = $(el).closest('form').get(0);
		if (form.loginId.value.length == 0) {
			validLoginId = '';
			return;
		}
		$.get('../member/getLoginIdDup', {
			isAjax : 'Y',
			loginId : form.loginId.value
		}, function(data) {
			$('.checkDup-msg').html('<div class="">' + data.msg + '</div>')
			if (data.success) {
				validLoginId = data.data1;
			} else {
				validLoginId = '';
			}
		}, 'json');
	}
	// 	checkLoginIdDup(); // 매번 실행
	const checkLoginIdDupDebounced = _.debounce(checkLoginIdDup, 300); // 실행 빈도 조절
</script>

<!-- 배경 -->
<div id="background" style="position: fixed; width: 100%; height: 100%; top: 0; left: 0; z-index: -1;"></div>

<!-- 중앙 정렬된 하얀색 박스 (화면의 절반 크기) -->
<section class="con flex-grow flex-col justify-center items-center m-16 bg-white rounded-lg">

	<section class="mt-24 text-xl px-4">
		<div class="mx-auto">
			<form action="../member/doJoin" method="POST" onsubmit="JoinForm__submit(this); return false;">
				<table class="table" border="1" cellspacing="0" cellpadding="5" style="width: 100%; border-collapse: collapse;">
					<tbody>
						<tr>
							<th>아이디</th>
							<td style="text-align: center;">
								<input onkeyup="checkLoginIdDupDebounced(this);"
									class="input input-bordered input-primary input-sm w-full max-w-xs" name="loginId" autocomplete="off"
									type="text" placeholder="아이디를 입력해주세요." />
							</td>

						</tr>
						<tr>
							<th></th>
							<td style="text-align: center;">
								<div class="checkDup-msg"></div>
							</td>
						</tr>

						<tr>
							<th>비밀번호</th>
							<td style="text-align: center;">
								<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="loginPw" autocomplete="off"
									type="text" placeholder="비밀번호를 입력해주세요." />
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td style="text-align: center;">
								<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="name" autocomplete="off"
									type="text" placeholder="이름을 입력해주세요." />
							</td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td style="text-align: center;">
								<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="nickname" autocomplete="off"
									type="text" placeholder="닉네임을 입력해주세요." />
							</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td style="text-align: center;">
								<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="cellphoneNum"
									autocomplete="off" type="text" placeholder="전화번호를 입력해주세요." />
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td style="text-align: center;">
								<input class="input input-bordered input-primary input-sm w-full max-w-xs" name="email" autocomplete="off"
									type="text" placeholder="이메일을 입력해주세요." />
							</td>
						</tr>
						<tr>
							<th></th>
							<td style="text-align: center;">
								<button type="submit" class="btn btn-primary">가입</button>
							</td>

						</tr>
					</tbody>
				</table>
			</form>
			<div class="btns">
				<button class="btn" type="button" onclick="history.back()">뒤로가기</button>
			</div>
		</div>
	</section>

</section>

<%@ include file="../common/foot.jspf"%>