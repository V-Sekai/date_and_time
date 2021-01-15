const SECONDS_PER_DAY = 86400

const MERIDIEM_ANTE = "am"
const MERIDIEM_POST = "pm"

class DateAndTime extends Reference:
	var seconds: int = 0
	var minutes: int = 0
	var hours: int = 0
	var days: int = 0
	var months: int = OS.MONTH_JANUARY
	var years: int = 0
	func serialize_save_binary(p_file: File) -> void:
		p_file.store_8(seconds)
		p_file.store_8(minutes)
		p_file.store_8(hours)
		p_file.store_16(days)
		p_file.store_8(months)
		p_file.store_32(years)
	
	func serialize_load_binary(p_file: File) -> void:
		seconds = p_file.get_8()
		minutes = p_file.get_8()
		hours = p_file.get_8()
		days = p_file.get_16()
		months = p_file.get_8()
		years = p_file.get_32()

static func get_month_from_string(p_string: String) -> int:
	var lower_string: String = p_string.to_lower()
	
	match lower_string:
		"january":
			return OS.MONTH_JANUARY
		"february":
			return OS.MONTH_FEBRUARY
		"march":
			return OS.MONTH_MARCH
		"april":
			return OS.MONTH_APRIL
		"may":
			return OS.MONTH_MAY
		"june":
			return OS.MONTH_JUNE
		"july":
			return OS.MONTH_JULY
		"august":
			return OS.MONTH_AUGEST
		"september":
			return OS.MONTH_SEPTEMBER
		"october":
			return OS.MONTH_OCTOBER
		"november":
			return OS.MONTH_NOVEMBER
		"december":
			return OS.MONTH_DECEMBER
		_:
			return -1
		
static func get_string_from_month(p_month: int) -> String:
	match p_month:
		OS.MONTH_JANUARY:
			return "January"
		OS.MONTH_FEBRUARY:
			return "February"
		OS.MONTH_MARCH:
			return "March"
		OS.MONTH_APRIL:
			return "April"
		OS.MONTH_MAY:
			return "May"
		OS.MONTH_JUNE:
			return "June"
		OS.MONTH_JULY:
			return "July"
		OS.MONTH_AUGUST:
			return "August"
		OS.MONTH_SEPTEMBER:
			return "September"
		OS.MONTH_OCTOBER:
			return "October"
		OS.MONTH_NOVEMBER:
			return "November"
		OS.MONTH_DECEMBER:
			return "December"
		_:
			return ""
		
static func get_string_from_month_tr(p_month):
	match p_month:
		OS.MONTH_JANUARY:
			return "MONTH_JANUARY"
		OS.MONTH_FEBRUARY:
			return "MONTH_FEBRUARY"
		OS.MONTH_MARCH:
			return "MONTH_MARCH"
		OS.MONTH_APRIL:
			return "MONTH_APRIL"
		OS.MONTH_MAY:
			return "MONTH_MAY"
		OS.MONTH_JUNE:
			return "MONTH_JUNE"
		OS.MONTH_JULY:
			return "MONTH_JULY"
		OS.MONTH_AUGUST:
			return "MONTH_AUGUST"
		OS.MONTH_SEPTEMBER:
			return "MONTH_SEPTEMBER"
		OS.MONTH_OCTOBER:
			return "MONTH_OCTOBER"
		OS.MONTH_NOVEMBER:
			return "MONTH_NOVEMBER"
		OS.MONTH_DECEMBER:
			return "MONTH_DECEMBER"
		_:
			return ""
		
static func get_string_from_weekday(p_day: int) -> String:
	match p_day:
		OS.DAY_SUNDAY:
			return "Sunday"
		OS.DAY_MONDAY:
			return "Monday"
		OS.DAY_TUESDAY:
			return "Tuesday"
		OS.DAY_WEDNESDAY:
			return "Wednesday"
		OS.DAY_THURSDAY:
			return "Thursday"
		OS.DAY_FRIDAY:
			return "Friday"
		OS.DAY_SATURDAY:
			return "Saturday"
		_:
			return ""
		
static func get_string_from_weekday_tr(p_day):
	match p_day:
		OS.DAY_SUNDAY:
			return "DAY_SUNDAY"
		OS.DAY_MONDAY:
			return "DAY_MONDAY"
		OS.DAY_TUESDAY:
			return "DAY_TUESDAY"
		OS.DAY_WEDNESDAY:
			return "DAY_WEDNESDAY"
		OS.DAY_THURSDAY:
			return "DAY_THURSDAY"
		OS.DAY_FRIDAY:
			return "DAY_FRIDAY"
		OS.DAY_SATURDAY:
			return "DAY_SATURDAY"
		_:
			return ""

static func get_is_leap_year(p_year: int) -> bool:
	if ((p_year % 4) || ((p_year % 100 == 0) && (p_year % 400))):
		return false
	else:
		return true

static func get_number_of_days_for_current_month(p_month: int, p_year: int) -> int:
	if (p_month == OS.MONTH_FEBRUARY):
		if(get_is_leap_year(p_year)):
			return 29
		else:
			return 28
	else:
		return 31 - (p_month - 1) % 7 % 2
	
static func get_month_and_day_for_current_day_of_the_year(p_day: int, p_year: int) -> Dictionary:
	var day_incrementation:int = 0
	var days_in_month: int = 0
	var month_and_day: Dictionary = {}
	
	for current_month in range(OS.MONTH_JANUARY, OS.MONTH_DECEMBER+1):
		days_in_month = get_number_of_days_for_current_month(current_month, p_year)
			
		if(p_day > day_incrementation and p_day <= day_incrementation + days_in_month):
			month_and_day["day"] = p_day - day_incrementation
			month_and_day["month"] = current_month
			break
			
		day_incrementation += days_in_month
			
	return month_and_day
	
static func get_number_of_days_for_current_year(p_year: int) -> int:
	if(get_is_leap_year(p_year)):
		return 366
	else:
		return 365
	
static func determine_day_of_the_week(p_day: int, p_month: int, p_year: int) -> int:
	var offset: Array = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334]
	var week: Array = [OS.DAY_SUNDAY, OS.DAY_MONDAY, OS.DAY_TUESDAY, OS.DAY_WEDNESDAY, OS.DAY_THURSDAY, OS.DAY_FRIDAY, OS.DAY_SATURDAY]
	
	var after_feburary: int = 1
	
	if(p_month > 2):
		after_feburary = 0
		
	var aux: int = int(p_year) - 1700 - after_feburary
	
	var days_of_week: int = 5
	days_of_week += (aux + after_feburary) * 365                  
	days_of_week += aux / 4 - aux / 100 + (aux + 100) / 400     
	days_of_week += offset[int(p_month) - 1] + (int(p_day) - 1)               
	days_of_week = days_of_week % 7
	
	return week[days_of_week]
	
static func determine_day_of_the_year(p_day: int, p_month: int, p_year: int) -> int:
	var n1: int = floor(275 * p_month / 9)
	var n2: int = floor((p_month + 9) / 12)
	var n3: int = (1 + floor ( (p_year - 4 * floor (p_year / 4) + 2) / 3) )
	return n1 - (n2 * n3) + p_day - 30
