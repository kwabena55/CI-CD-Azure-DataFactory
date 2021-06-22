let
    Source = Kusto.Contents("https://help.kusto.windows.net", "Samples", "StormEvents | limit 1000 StormEvents | count StormEvents | project EndTime,EpisodeId StormEvents | where EpisodeId > 2560 StormEvents | distinct State StormEvents | distinct State | count StormEvents | project DamageProperty,DeathsDirect,State,EventId | limit 10 StormEvents | project Damage=DamageProperty,Death=DeathsDirect, Stat=State StormEvents | where State =~""mississippi"" StormEvents | getschema StormEvents |limit 10000 StormEvents | summarize DamageProp=sum(DamageProperty),Crops=sum(DamageCrops) by State StormEvents | summarize DamageProp=sum(DamageProperty),Crops=sum(DamageCrops), count_Instances=count() by State StormEvents | summarize DamageProp=sum(DamageProperty),Crops=sum(DamageCrops), count_Instances=count() by State | where count_Instances >=2000 StormEvents | summarize DamageProp=sum(DamageProperty),Crops=sum(DamageCrops), count_Instances=count() by State |where count_Instances <2000 StormEvents | summarize DamageProp=sum(DamageProperty), DamageProp_ratio= sum(DamageProperty)/count() by State StormEvents |summarize DamageProp=sum(DamageProperty), DamageProp_ratio= sum(DamageProperty)/count() by month=monthofyear(StartTime) | order by month asc StormEvents |summarize DamageProp=sum(DamageProperty), DamageProp_ratio= sum(DamageProperty)/count() by year=getyear(StartTime) | order by year StormEvents | summarize DamageProp=sum(DamageProperty), DamageProp_ratio= sum(DamageProperty)/count() by week=startofweek(StartTime) | sort by endofmonth(week,1) StormEvents |summarize avg_deaths= avg(DamageProperty) by State,MonthStart=startofmonth(todatetime(StartTime)) StormEvents |where State in (""OHIO"",""HAWAII"") |summarize avg_deaths= avg(DamageProperty) by State,MonthStart=startofmonth(todatetime(StartTime)) StormEvents | summarize DamCrop=sum(DamageCrops) by State StormEvents | where State contains ""SA"" | extend TotalDamage=DamageCrops+ DamageProperty StormEvents | where State contains ""SA"" | summarize TotalDamage=(DamageCrops + DamageProperty) by State StormEvents | where State contains ""SA"" | extend TotalDamage=DamageCrops+ DamageProperty |project EventId,StartTime,TotalDamage let StateCodes= StormEvents | distinct State; StateCodes | join StormEvents on $left.State == $right.State let StateCodes= StormEvents | distinct State; StateCodes | join kind=inner StormEvents on $left.State == $right.State let Enddate= StormEvents | distinct(EndTime); Enddate | join StormEvents on $left.EndTime == $right.EndTime | where State in ( ""NEW YORK"",""VIRGINIA"",""CALIFORNIA"") |extend TotalDamage=DamageCrops+ DamageProperty, totaltest=DamageCrops*2 | project EventId,TotalDamage,DeathsDirect,DeathsIndirect,DamageCrops,DamageProperty,totaltest let enddate=StormEvents |limit 1000 |distinct EndTime ; enddate |join StormEvents on $left.EndTime ==$right.EndTime |where State in ( ""NEW YORK"",""VIRGINIA"",""CALIFORNIA"") |project State,DamageProperty |order by DamageProperty desc |render barchart .create-or-alter function with ( folder=""Demo"", docstring=""Simple Demo function"",skipvalidation=""true"") MyFunction9() { StormEvents |limit 1000 } MyFunction1() .create-or-alter function with (folder = ""Demo"", docstring = ""Demo function with parameter"", skipvalidation = ""true"") MyFunction2(myLimit:long) { StormEvents | limit myLimit } MyFunction2(20) .create-or-alter function with (folder = ""Demo"", docstring = ""Function calling other function"", skipvalidation = ""true"") MyFunction3() { MyFunction(100) } MyFunction3() .create-or-alter function with (folder = ""Demo"", docstring = ""Function calling other function"", skipvalidation = ""true"") MyFunction4() { let limitVar = 100; let result = MyFunction(limitVar); result } MyFunction4() .create-or-alter function with ( folder=""Demo"",docstring=""Customised Functions"", skipvalidation=""true"") MyFunction4 () {let enddate=StormEvents |limit 1000 |distinct EndTime ; enddate |join StormEvents on $left.EndTime ==$right.EndTime |where State in ( ""NEW YORK"",""VIRGINIA"",""CALIFORNIA"") |project State,DamageProperty |order by DamageProperty desc |render barchart } .create-or-alter function with (folder = ""Demo"", docstring = ""Demo function with parameter"", skipvalidation = ""true"") MyFunction5(myLimit:long) {StormEvents | limit myLimit} let NewTab=MyFunction1() | project EventId, EndTime | where EventId == 7821 ; NewTab | join kind = inner StormEvents on $left.EventId ==$right.EventId let Addition = (arg1:long,arg2:long) {arg1 + arg2}; print(Addition(4,5)) let Statement= (arg1:string,arg2:string,arg3:string){let enddate=StormEvents |limit 1000 |distinct EndTime ; enddate |join StormEvents on $left.EndTime ==$right.EndTime |where State in ( arg1,arg2,arg3) |project State,DamageProperty |order by DamageProperty desc |render barchart} ; Statement(""NEW YORK"",""VIRGINIA"",""CALIFORNIA"") StormEvents | where State contains ""SA"" | summarize TotalDamage=sum(DamageCrops + DamageProperty) by State let ContainStatement= (arg1:string) {StormEvents | where State contains arg1 | summarize TotalDamage=sum(DamageCrops + DamageProperty) by State}; ContainStatement(""SA"") let ContainStatement= (arg1:string) {StormEvents | where State contains arg1 | summarize TotalDamage=sum(DamageCrops + DamageProperty) by State | render barchart}; ContainStatement(""OR"") .show function MyFunction1 StormEvents | limit 10 | order by EndTime desc StormEvents | sort by EndTime desc | limit 10 StormEvents | sort by EndTime desc | top 10 Covid19 | order by Active desc Covid19 | summarize CountryCount= count(Country) by Country Covid19 | summarize No_of_countries= dcount(Country) Covid19 | distinct Country Covid19 | where State == ""Japan"" |order by State desc Covid19 | where Country in (""Japan"",""India"") | summarize TotalActive=sum(Active), TotalRecovered= sum(Recovered) by Country Covid19 | where Country in (""Japan"",""India"",""USA"") | summarize sum(Active),sum(Recovered) by Country Covid19 | where Country in (""Japan"",""India"",""USA"") | project Active,Recovered,Country | order by Country desc Covid19 | summarize max(Deaths) by Country Covid19 | summarize min(Deaths) by Country Covid19 | where Country == ""India"" | where Timestamp == todatetime(""20200131"") Covid19 | where Country == ""India"" and Timestamp == todatetime(""20200131"") Covid19 | summarize AcerageRec=avg(Recovered) by Country Covid19 | summarize AcerageRec=toint(avg(Recovered)) by Country Covid19 | summarize AcerageRec=round(avg(Recovered)) by Country Covid19 | summarize No_of_States=dcount(State) by Country Covid19 | summarize Statee= arg_max(Deaths, State) by Country Covid19 | where Timestamp between (todatetime(""20200401"")..todatetime(""20200502"")) | summarize max(Deaths) by Country Covid19 | where Country == ""Japan"" | summarize TotalCases=sum(Active) by Month=monthofyear(todatetime(Timestamp)),Country Covid19 | where Country == ""Japan"" | extend TotalCases=Active+Recovered+Deaths+Confirmed | summarize TotalCases=sum(Active) by Month=monthofyear(todatetime(Timestamp)),Country let Temptable=Covid19 | distinct CountryCode; Covid19 | join kind=inner Covid19 on $left.CountryCode ==$right.CountryCode let subtract=(arg:int,arg1:int) {arg-arg1} .create-or-alter function with (folder = ""Demo"", docstring = ""Demo function with parameter"", skipvalidation = ""true"") MyFunction56(code:string) {Covid19 | summarize sum(Recovered) by code} let Functionn1=(countrycode:string,code:string ) {Covid19|summarize sum(Recovered) by code | where countrycode == code} let Functionn1=(countrycode:string,code:string ) {StormEvents | where countrycode == code|summarize sum(DeathsDirect) by countrycode }; Functionn1(""NEW YORK"",""NEW YORK"") let myfunc= (datetime1: datetime, datetime2: datetime, countrycode: string, country: string) { Covid19 | where todatetime(Timestamp) between (todatetime(datetime1)..todatetime(datetime2)) and CountryCode == countrycode and Country == country | summarize sum(Active) by CountryCode }; myfunc(todatetime(""20200401""),todatetime(""20200502""),""IN"",""India"") StormEvents |summarize sum(DamageProperty) by bin(StartTime,1d) StormEvents |summarize sum(DamageProperty) by bin(StartTime,24m) StormEvents | where StartTime > ago(6300d) | summarize sum(DamageCrops) by bin(StartTime,1m) StormEvents | where StartTime > ago(2400h) | summarize sum(DamageCrops) by bin(StartTime,1m)", [Timeout = #duration(0,0,4,0), ClientRequestProperties = [#"query_language" = "csl"]])
in
    Source



CREATE TABLE tbl_ADFPipelineExecutions
(adfname nvarchar(225) not null,
PipelineName nvarchar(225) not null,
TriggerName nvarchar(225) not null,
RunId nvarchar(225) not null,
TriggerTime nvarchar(225) not null)



---
CREATE PROCEDURE Usp_ADFPipelineExecutions(
@adfname nvarchar(225) ,
@PipelineName nvarchar(225) ,
@TriggerName nvarchar(225) ,
@RunId nvarchar(225 ,
@TriggerTime nvarchar(225)
)

as


BEGIN


INSERT INTO tbl_ADFPipelineExecutions
VALUES
(
@adfname ,
@PipelineName ,
@TriggerName  ,
@RunId ,
@TriggerTime
)


END
