package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Weather {

	private String baseTime; // 기준 시간
	private String temperature; // 현재 기온
	private String minTemperature; // 최저 기온
	private String maxTemperature; // 최고 기온
	private String precipitationType; // 강수 형태
	private String precipitationProbability; // 강수 확률
	private String skyCondition; // 하늘 상태
	private String windDirection; // 풍향
	private String windSpeed; // 풍속
	private String waveHeight; // 파고

}
