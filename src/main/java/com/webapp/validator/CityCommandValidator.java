package com.webapp.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.webapp.command.CityCommand;

public class CityCommandValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return CityCommand.class.isAssignableFrom(clazz);//할당 가능하면 호환 가능하다 라는 거임
	}

	@Override
	public void validate(Object target, Errors errors) {
		CityCommand city = (CityCommand) target;
		/*
		 * validation
		 */
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required");//일부러 에러셋팅
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "countryCode", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "district", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "population", "required");
		
		
		if(city.getName().length() > 35) {
			errors.rejectValue("name", "length", new Object[] {35},"");
		}
		
		if (city.getPopulation() < 0) {
			errors.rejectValue("population", "minus");
		}
	}

}
