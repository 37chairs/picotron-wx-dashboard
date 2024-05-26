-- Helper function to determine if a year is a leap year
function is_leap_year(year)
    return (year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0)
end

-- Helper function to get the number of days in a month
function get_days_in_month(year, month)
    local days_in_month = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
    if month == 2 and is_leap_year(year) then
        return 29
    else
        return days_in_month[month]
    end
end

function convert_timestamp(unix_timestamp, offset)
    -- Adjust the timestamp by the offset (convert hours to seconds)
    local adjusted_timestamp = unix_timestamp + (offset * 3600)

    local days_in_year = 365
    local timestamp = adjusted_timestamp
    local year = 1970
    local month = 1
    local day = 1
    local hour = 0
    local min = 0
    local sec = 0

    -- Calculate seconds, minutes, hours, and days
    sec = timestamp % 60
    timestamp = math.floor(timestamp / 60)
    min = timestamp % 60
    timestamp = math.floor(timestamp / 60)
    hour = timestamp % 24
    timestamp = math.floor(timestamp / 24)

    -- Calculate year
    while timestamp >= days_in_year do
        if is_leap_year(year) then
            timestamp = timestamp - 366
        else
            timestamp = timestamp - 365
        end
        year = year + 1
    end

    -- Calculate month and day
    while timestamp >= get_days_in_month(year, month) do
        timestamp = timestamp - get_days_in_month(year, month)
        month = month + 1
    end
    day = day + timestamp

    -- Return the date and time as a table
    local time_table = {
        year = year,
        month = month,
        day = day,
        hour = hour,
        min = min,
        sec = sec
    }

    return time_table
end
