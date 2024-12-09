package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class UsrProxyController {

	@Value("${NAVER_SEARCH_CLIENT_ID}")
	private String CLIENT_ID;

	@Value("${NAVER_SEARCH_CLIENT_SECRET}")
	private String CLIENT_SECRET;

	// 이미지 검색 API 프록시
	@GetMapping("/proxy/search/image")
	public ResponseEntity<String> searchImage(@RequestParam String query) {
		String apiUrl = "https://openapi.naver.com/v1/search/image?query=" + query;

		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.set("X-Naver-Client-Id", CLIENT_ID);
		headers.set("X-Naver-Client-Secret", CLIENT_SECRET);

		HttpEntity<String> entity = new HttpEntity<>(headers);
		ResponseEntity<String> response = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class);

		return response;
	}
}