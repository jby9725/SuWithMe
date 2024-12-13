###(INIT 시작)#########
# DB 세팅
DROP DATABASE IF EXISTS `SuWithMe`;
CREATE DATABASE `SuWithMe`;

USE `SuWithMe`;

# 게시글 테이블 생성
CREATE TABLE article (
    `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `regDate` DATETIME NOT NULL,
    `updateDate` DATETIME NOT NULL,
    `memberId` INT(10) NOT NULL, 
    boardId INT(10) UNSIGNED NOT NULL,
    `title` VARCHAR(50) NOT NULL,
    `body` TEXT NOT NULL,
    hit INT UNSIGNED NOT NULL DEFAULT 0,
    `goodReactionPoint` INT(10) UNSIGNED NOT NULL DEFAULT 0,
    `badReactionPoint` INT(10) UNSIGNED NOT NULL DEFAULT 0
);


# 회원 테이블 생성
CREATE TABLE `member`(
      id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
      regDate DATETIME NOT NULL,
      updateDate DATETIME NOT NULL,
      loginId CHAR(30) NOT NULL,
      loginPw CHAR(100) NOT NULL,
      `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (3=일반,7=관리자)',
      `name` CHAR(20) NOT NULL,
      nickname CHAR(20) NOT NULL,
      cellphoneNum CHAR(20) NOT NULL,
      email CHAR(50) NOT NULL,
      delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부 (0=탈퇴 전, 1=탈퇴 후)',
      delDate DATETIME COMMENT '탈퇴 날짜'
);

# 게시판(board) 테이블 생성
CREATE TABLE board (
      id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
      regDate DATETIME NOT NULL,
      updateDate DATETIME NOT NULL,
      `code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항) free(자유) QnA(질의응답) ...',
      `name` CHAR(20) NOT NULL UNIQUE COMMENT '게시판 이름',
      delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1=삭제 후)',
      delDate DATETIME COMMENT '삭제 날짜'
);

# 좋아요/싫어요 테이블 구현
# memberId : 어떤 회원이 눌렀는지, relId : 몇번에 눌렀는지, relTypeCode : 글인지 댓글인지, `point` : 좋아요(+)인지, 싫어요(-)인지
CREATE TABLE reactionPoint (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL,
    relId INT(10) UNSIGNED NOT NULL,
    `point` INT(10) NOT NULL
);

## 게시판(board) 테스트 데이터 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'NOTICE',
`name` = '통합 공지사항';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'FREE',
`name` = '통합 자유 게시판';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'POOL',
`name` = '실내 수영 위드미 게시판';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'BEACH',
`name` = '야외 수영 위드미 게시판';

## 회원 테스트 데이터 생성
## (관리자)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = 'admin',
`authLevel` = 7,
`name` = '관리자',
nickname = '관리자',
cellphoneNum = '01012341234',
email = 'abc@gmail.com';

## (일반)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test1',
loginPw = 'test1',
`name` = '회원1_이름',
nickname = '회원1_닉네임',
cellphoneNum = '01043214321',
email = 'abcd@gmail.com';

## (일반)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test2',
loginPw = 'test2',
`name` = '회원2_이름',
nickname = '회원2_닉네임',
cellphoneNum = '01056785678',
email = 'abcde@gmail.com';

## (일반)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test3',
loginPw = 'test3',
`name` = '회원3_이름',
nickname = '회원3_닉네임',
cellphoneNum = '01065656565',
email = 'goast@gmail.com';

# reply 테이블 생성
CREATE TABLE reply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `body`TEXT NOT NULL
);

# reply 테이블에 좋아요 관련 컬럼 추가
ALTER TABLE reply ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE reply ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# 기존의 회원 비번을 암호화
UPDATE `member`
SET loginPw = SHA2(loginPw,256);

###(INIT 끝)
##########################################
###(프로젝트 고유 테이블 관련)

## 수영장 정보 테이블 생성
CREATE TABLE pool (
    id INT PRIMARY KEY,		-- 번호
    statusCode VARCHAR(10) DEFAULT NULL,	-- 영업상태구분코드
    statusName VARCHAR(50) DEFAULT NULL,	-- 영업상태명
    detailStatusCode VARCHAR(10) DEFAULT NULL,	-- 상세영업상태코드
    detailStatusName VARCHAR(50) DEFAULT NULL,	-- 상세영업상태명
    suspensionStartDate DATE DEFAULT NULL,	-- 휴업시작일자
    suspensionEndDate DATE DEFAULT NULL,		-- 휴업종료일자
    callNumber VARCHAR(20) DEFAULT NULL,	-- 소재지전화
    postalCodeLocation VARCHAR(255) DEFAULT NULL,	-- 소재지우편번호
    postalCodeStreet TEXT(255) DEFAULT NULL,	-- 도로명우편번호
    addressLocation TEXT DEFAULT NULL,		-- 소재지전체주소
    addressStreet TEXT DEFAULT NULL,		-- 도로명전체주소
    `name` TEXT DEFAULT NULL,			-- 사업장명
    latitude VARCHAR(20) DEFAULT NULL,		-- 좌표정보(x)
    longitude VARCHAR(20) DEFAULT NULL	-- 좌표정보(y)
);

## 수영 일정 테이블 생성
CREATE TABLE `event` (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- 일정 고유 ID
    title VARCHAR(255) NOT NULL,        -- 일정 제목
    `body` TEXT,                        -- 일정 설명
    createDate DATETIME NOT NULL,       -- 일정 생성 시각
    updateDate DATETIME NOT NULL,       -- 일정 수정 시각
    startDate DATE NOT NULL,        -- 일정 시작 날짜와 시간
    endDate DATE,                   -- 일정 종료 날짜와 시간 (없을 경우 NULL)
    completed BOOLEAN DEFAULT FALSE,    -- 일정 완료 여부 (오수완 체크용)
    memberId INT                          -- 일정 작성자의 사용자 ID (FK)
);

## 해수욕장 정보 테이블 생성
CREATE TABLE beach (
    id INT PRIMARY KEY,		-- 번호
    `name` TEXT DEFAULT NULL,			-- 해수욕장명
    nx INT DEFAULT 0,			-- nx 값
    ny INT DEFAULT 0,			-- ny 값
    latitude VARCHAR(20) DEFAULT NULL,		-- 위도
    longitude VARCHAR(20) DEFAULT NULL	-- 경도
);
