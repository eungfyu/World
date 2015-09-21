package com.webapp.model;

import java.util.List;

import com.webapp.util.Pagination;

public class CityList extends Pagination {
	List<City> cities;

	public CityList() {
		super();
	}

	public CityList(int itemsPerPage, int pagesPerGroup) {
		super(itemsPerPage,pagesPerGroup);
	}

	public List<City> getCities() {
		return cities;
	}

	public void setCities(List<City> cities) {
		this.cities = cities;
	}

}
