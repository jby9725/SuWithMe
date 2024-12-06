<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="임시 비밀번호 발급"></c:set>
<%@ include file="../common/head_NonOption.jspf"%>

<section class="mt-8 text-xl px-4">
	<div class="mx-auto">
		<h1>비밀번호 찾기 결과</h1>

		<!-- 성공 메시지 -->
		<c:if test="${not empty msg}">
			<p style="color: green; font-size: 1.2rem;">${msg}</p>
		</c:if>

		<!-- 임시 비밀번호 표시 -->
		<c:if test="${not empty tempPassword}">
			<div style="margin-top: 20px;">
				<h2 style="font-size: 1.5rem; color: #333;">임시 비밀번호</h2>
				<p style="font-size: 1.2rem; font-weight: bold; color: #007BFF;">${tempPassword}</p>
				<p style="margin-top: 10px; color: #555;">임시 비밀번호를 복사하여 로그인 후 변경해주세요.</p>
			</div>
		</c:if>

		<!-- 돌아가기 버튼 -->
		<div style="margin-top: 30px;">
			<a href="/usr/member/login"
				style="padding: 10px 20px; background: #007BFF; color: white; text-decoration: none; border-radius: 5px;">로그인
				페이지로 이동</a>
		</div>
	</div>
</section>

<!-- 배경 -->
<div id="background" style="position: fixed; width: 100%; height: 100%; top: 0; left: 0; z-index: -1;"></div>

<%@ include file="../common/foot.jspf"%>
