
select * 
from sqlproject..cd
order by 1,2

select * 
from sqlproject..cv
order by 1,2

-- finding out the death percentage 
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as death_ratio
from sqlproject..cd
where location = 'India'
order by 1,2
--finding out list of those countries where death_ratio is more than 4 

select location,  max(total_deaths/total_cases)*100 as highest_death_ratio
from sqlproject..cd
group by location
having max(total_deaths/total_cases)*100 > 4
order by 1,2

--  finding out chances of getting infected in India
select location, date, total_cases, population, (total_cases/population)*100 as infection_ratio
from sqlproject..cd
where location = 'India'
order by date desc 

--looking data with highest infection count and highest infection rate as compared to population
select location, population, max(total_cases) as highest_infection_count, max(total_cases/population)*100 as highest_infection_ratio
from sqlproject..cd
group by location, population
order by highest_infection_ratio desc
 
--looking for countries with highest death count 
select location, max(cast(total_deaths as int)) as highest_death_count
from sqlproject..cd
where continent is not null
group by location
order by highest_death_count desc

--looking for highest death count for continents
select continent ,max(cast(total_deaths as int )) as totaldeathcount
from sqlproject..cd
where continent is not null
group by continent
order by totaldeathcount desc

-- showing the continent with highest death count per population
select continent, population ,max(cast(total_deaths as int )) as totaldeathcount
from sqlproject..cd
where continent is not null
group by continent
order by totaldeathcount desc

--global numbers - new cases , new deaths, death percentage 
select date , sum (new_cases), sum (cast(new_deaths as int)), sum (cast(new_deaths as int))/sum (new_cases)*100 as death_percentage
from sqlproject..cd
where continent is not null
group by date
order by 1,2	

--joining two table through location and date 
select *
from sqlproject..cd
join sqlproject..cv
on cd.location = cv.location
and cd.date = cv.date
order by 1,2

--looking for total population nad total vaccination
select cd.location,cd.date, cd.population, cv.new_vaccinations
from sqlproject..cd
join sqlproject..cv
on cd.location = cv.location
and cd.date = cv.date
where cd.continent is not null
order by 1,2
-- adding all the new \vaccinations in order of date 
select cd.continent, cd.location,cd.date, cd.population, cv.new_vaccinations
,sum (convert(int,cv.new_vaccinations))over(partition by cd.location  order by cd.location,cd.date)
from sqlproject..cd
join sqlproject..cv
on cd.location = cv.location
and cd.date = cv.date
where cd.continent is not null
order by 1,2
