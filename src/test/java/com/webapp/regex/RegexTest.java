package com.webapp.regex;

import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexTest {
	/*
	 * 문자열 검색, 대체, 추출 ==> 정규표현식(Regular Expression)
	 * 
	 * . ==> 뉴라인문자(new line문자)을 제외한 모든 문자
	 * ^ ==> Line Start, 시작(start)
	 * $ ==> Line End, 라인의 끝(end)
	 * * ==> 앞문자가 0개 이상 반복
	 * + ==> 앞문자가 1개 이상 반복
	 * [AYZ] ==> A, Y, Z 중 한 글자씩만 올 경우 TRUE. 
	 * [A-Z] ==> A부터 Z까지 올 수 있다. 대문자만
	 * [A-Z0-9] ==> A부터 Z까지 올 수 있다. 대문자만 + 0부터 9까지 올 수 있음
	 * [A-Z0-9]{3} ==> {}의 앞자리 문자를 반복하는 횟수
	 * {n,} ==> 앞문자를 n개 이상 반복
	 * {n, m} ==> 앞문자가 n개 이상이고 m개 이하 반복되는 횟수
	 */
	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		
//		String regex = "^.$";
//		String regex = "^A*$"; //^A*$ A가 0개 이상 반복된다능
//		String regex = "^A+$"; //^A+$ A가 1개 이상 반복된다능
//		String regex = "^[AYZ]$";
//		String regex = "^[A-Z]$";
//		String regex = "^[A-Z0-9]$";
//		String regex = "^[A-Z0-9]{3}$";
//		String regex = "^[A-Z0-9]{3, 5}$"; //3자리에서 5자리까지 입력 가능하다
//		String regex = "^[가-힣]{3, 5}$"; //한글의 표기. 가-힣 이게 한글의 범위
		String regex = "[A-Z0-9]"; //한 라인에서 영문자가 세 자리 이상 반복되는 경우가 있는지 없는지 체크
//		String regex = "[A-Za-z]{3}";//한 라인에서 영문자가 세 자리 이상 반복되는 경우가 있는지 없는지 체크
		
		while(true){
		String line = scan.nextLine();
		System.out.println("line = [" + line + "]");
		Pattern pattern  = Pattern.compile(regex);
		Matcher m= pattern.matcher(line);
		System.out.println("match ="+ m.find());		
		
		//Pattern.matches 불리언을 리턴한다. ^.$ 하나의 글자일 경우만 true, .이 한개찍혀있잖음. 두번째" "에 글자 두개넣으면 false남
		System.out.println("match = "+ Pattern.matches(regex, line));
		}
	}

}
