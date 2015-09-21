package com.webapp.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.webapp.command.CityCommand;
import com.webapp.command.Code;
import com.webapp.mapper.CityMapper;
import com.webapp.mapper.CountryMapper;
import com.webapp.model.City;
import com.webapp.validator.CityCommandValidator;

@Controller
@RequestMapping("/city")
public class CityController {
	static Log log = LogFactory.getLog(CityController.class);
	
	@Autowired//필드인젝션
	CountryMapper countryMapper;
	@Autowired
	CityMapper cityMapper;
	@Autowired
	CityCommandValidator validator;
	
	String getCities(){
		return "";
	}
	
	
	@RequestMapping("/district/{countrycode:[A-Z]{3}}")//알파벳 3자리까지만 받는다
	String getDistricts(@PathVariable String countrycode, Model model){//@PathVariable이 path에 있는 값을 countrycode에 넣는다.
		log.info("getDistricts()... countryCode = " +countrycode);
		
		List<String> districts=cityMapper.selectDistricts(countrycode);
		
		model.addAttribute("districts", districts);
		
		return "city/districts";
	}
	
	@RequestMapping()
	String listbyParameter(String countrycode, Model model){
		model.addAttribute("countrycode", countrycode);
		
		List<Code> list = countryMapper.selectCodes();
		
		for(Code c : list) {
			log.info("code = " + c.getCode()+" "+
					 "name = " + c.getName());
		}
		
		return "city/list";
	}
	@RequestMapping("/list")
	void listByParameter(HttpServletRequest request, Model model){
		String countrycode = request.getParameter("countrycode");
		log.info("requestURI ="+request.getRequestURI());
		model.addAttribute("countrycode", countrycode);
	}
	
	@ModelAttribute("countryCode")
	List<Code> getCountryCode(){
		
		List<Code> model = countryMapper.selectCodes();
//		for (Code c : list) {
//			model.add(new District(c.getCode(), c.getName()));
//		}
		log.info("getCountryCode()... size = " + model.size());
		return model;
	}
	
	@ModelAttribute("districts")
	List<String> getDistricts(String countryCode){
		List<String> model = cityMapper.selectDistricts(countryCode);
		
		log.info("getDistricts()... size = " + model.size());
		return model;
	}
	
	
	//여러개 있는 경우. city를 등록하려고 함
	@RequestMapping(value="/register", method=RequestMethod.GET)
	String registerForm(@ModelAttribute("city") CityCommand command){//파라미터 여러개를 맵핑처리하고 싶을때 커맨드 객체를사용함
		log.info("registerForm()...");
		return "city/registerForm";
	}
	
	//여러개 있는 경우. city를 등록하려고 함
	@RequestMapping(value="/register", method=RequestMethod.POST)
	String register(@ModelAttribute("city") CityCommand command, Errors errors, Model model){//파라미터 여러개를 맵핑처리하고 싶을때 커맨드 객체를사용함
		log.info("register()... POST");

		/*
		 * CityCommand Validation 
		 */
		
		validator.validate(command, errors);
		
		if (errors.hasFieldErrors("name")){
		FieldError e = errors.getFieldError("name");
		String[] codes = e.getCodes();
		for (String s : codes) 
			log.info("["+s+"]");
			}
		
		if (errors.hasErrors()){
			errors.reject("city.register", new Object[] {command.getName()}, "City Global Error");//Global Error. 등록시 에러
			return "city/registerForm";
		}
		
		/*
		 * DB Register ==> Service를 사용해서 처리
		 */
		City city = command.getCity();
		cityMapper.insert(city);
		model.addAttribute("city", city);
		
		return "city/registerSuccess";
	}
	
	
	//여러개 있는 경우. city를 등록하려고 함
		@RequestMapping("/modify")
		String modify(@ModelAttribute("city") CityCommand command, Errors errors){//파라미터 여러개를 맵핑처리하고 싶을때 커맨드 객체를사용함. errors 파라미터에 에러 있을경우 던진다.
			if(errors.hasFieldErrors()){//필드들에 에러가 하나라도 있음?
				List<FieldError> fieldErrors =  errors.getFieldErrors();
				for (FieldError fe : fieldErrors) {
					log.info("field =" + fe.getField());
					log.info("ObjectName ="+ fe.getObjectName());
//					log.info("Code ="+ fe.getCode());//코드 하나 찍
					log.info("Code ="+ Arrays.toString(fe.getCodes()));//코드 여러개 배열로 만들어 찍
					log.info("RejectedValue ="+fe.getRejectedValue());
				}
			}
			
			return "city/modify";
		}
}
