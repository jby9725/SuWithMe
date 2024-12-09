# SuWithMe README

### 사용 기술 스택
Java, Spring Boot, JSP, Mysql
- 라이브러리
OpenCSV 라이브러리, proj4j 라이브러리, fullcalender 라이브러리, 네이버 이미지 검색 API, 네이버 지도 API, 공공데이터 기상청 날씨 조회 API, JSON 라이브러리

### 프로젝트 구조
Back : Controller, Service, Repository <br>
Front : JSP <br>
크게 기능적으로 회원 / 수영장 지도 / 수영 일정 관리 / 해수욕장 지도와 날씨 로 나눌 수 있다.

회원
![로그인](https://github.com/user-attachments/assets/a5d0a910-21c5-43b9-9eb0-314faf84eb61)

수영장 지도
![수영장 지도-마커클릭](https://github.com/user-attachments/assets/9658e8e7-e246-46d2-a3e6-f5edb339bb61)

수영 일정 관리
![수영 일정](https://github.com/user-attachments/assets/9fc5c9e5-d9c3-4593-b2ac-bcfafa5c54c3)

해수욕장 지도와 날씨
![해수욕장 지도-마커 클릭](https://github.com/user-attachments/assets/d696e4be-0837-4bc2-b7a9-a6a064eef347)

### 프로젝트 사용법
환경설정
사용 툴 : Spring Tool Suite 4
DB : MySQL

### 초기세팅
![초기세팅1](https://github.com/user-attachments/assets/17353a43-5ce7-4840-ac9e-78a2f9cabbe1)

![초기세팅2](https://github.com/user-attachments/assets/9c665954-e75c-4da6-aa44-f6990d0e491f)

### DB 테이블 생성
제공하는 기능 전부 원활한 테스트를 위해서는 데이터베이스가 구축되어 있어야 한다. DB.sql을 참고하여 테이블 구조를 생성하고 테스트 데이터(예: 게시판)를 생성한다.

### 커뮤니티 테스트
커뮤니티 기능의 CRUD를 테스트하기 위해서는 게시판(board) 데이터가 반드시 필요하다. DB.sql를 참고하자.

### 회원 기능 테스트
회원 가입부터 시작해야 한다. 비밀번호에 암호화 알고리즘이 들어갔기 때문에, 테스트 데이터로 회원을 생성해도 비밀번호가 일치하지 않아 해당 계정으로 로그인할 수 없다.

### 수영 일정 관리 테스트
수영 일정을 테스트 하기 위해서는 최소 1개의 계정이 필요하다. 회원가입이 필요하다. 메인 화면(첫 화면)에서 할 수 있다. 로고를 클릭하면 메인 화면으로 갈 수 있다.

### 수영장 지도 테스트
##### 출력할 데이터 준비
수영장 지도의 마커를 표시하기 위해서는 데이터가 필요하다. 프로젝트 내 src/main/resources/selectOnlyData_PoolInfo.csv 파일이 존재해야 한다.
브라우저에 localhost:8080/usr/pool/doSetting 을 입력하여 src/main/resources/selectOnlyData_PoolInfo.csv 에 있는 데이터를 DB에 저장한다. 이 csv 파일은 수영장의 정보에 대한 데이터셋이다.
해당 데이터중 좌표값이 지도에 나타낼 수 있는 위도/경도 값이 아니기 때문에 변환 및 보정을 해주어야 한다.
브라우저에 localhost:8080/usr/pool/doLatlonUpdate 을 입력하여 DB에 저장된 중부원점 좌표를 위도/경도 값으로 변환 및 보정을 해준다.

해수욕장 지도의 마커를 표시하기 위해서도 데이터가 필요하다. 프로젝트 내 src/main/resources/beach_info.csv 파일이 존재해야 한다.
브라우저에 localhost:8080/usr/beach/doSetting/CSV 를 입력하여 src/main/resources/beach_info.csv에 있는 데이터를 DB에 저장한다. 이 csv 파일은 해수욕장의 정보에 대한 데이터셋이다.

#### 데이터 파일의 최신화
데이터 파일의 출처는 공공데이터 포털에서 가져왔다.
수영장 데이터의 경우 공공데이터 포털에서 '행정안전부_수영장업'을 검색하여 나오는 CSV 파일을 필요한 데이터만 정제하여 사용하였다.
해수욕장 데이터의 경우 공공데이터 포털에서 '기상청_전국 해수욕장 날씨 조회서비스' 안의 참고 문서를 다운로드 받아 필요한 데이터만 정제하여 사용하였다.

### 네이버 지도 API 키 발급
수영장과 해수욕장의 지도를 표시하기 위해 네이버 지도 API를 사용하였기 때문에, 서비스를 제대로 제공하기 위해서는 네이버 지도 API 키가 필요하다.
.env 파일을 루트 디렉토리에 만들고, 다음과 같이 작성해야 한다.
```
NAVER_MAP_CLIENT_ID=새로 발급받은 클라이언트 키
NAVER_MAP_CLIENT_SECRET=새로 발급받은 시크릿 키
```

### 네이버 검색 API 키 발급
수영장 지도 기능 중에 수영장의 이미지를 검색하여 가져오는 API를 사용하였다. 마찬가지로 API키가 필요하다.
https://developers.naver.com/docs/serviceapi/search/image/image.md
에 접속하여 안내하는 절차대로 진행한다. 검색 API가 필요하다.

.env 파일에 마찬가지로 다음과 같은 내용을 추가해야 한다.
```
NAVER_SEARCH_CLIENT_ID=새로 발급받은 클라이언트 키
NAVER_SEARCH_CLIENT_SECRET=새로 발급받은 시크릿 키
```

### 공공데이터 API 키 발급
해수욕장의 날씨를 표시하는데에 공공데이터 기상청 API를 사용하였기 때문에 해당 API키가 필요하다.
공공데이터 사이트에 접속하여 ‘기상청_단기예보 ((구)_동네예보) 조회서비스’의 활용신청을 하면 된다.
.env 파일에 마찬가지로 다음과 같은 내용을 추가해야 한다.
```
OPEN_DATA_WEATHER_API_KEY=새로 발급받은 공공데이터 API 키
```







