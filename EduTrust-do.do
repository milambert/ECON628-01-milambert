**Merge by school code
use "C:\Users\miran\Desktop\sb_ca2016_all_csv_v3\Subgroup_Test.dta", clear
merge m:m schoolcode using "C:\Users\miran\Desktop\sb_ca2016_all_csv_v3\Entity.dta"
**change string to numeric for summary stats
foreach v of varlist percentagestandardexceeded percentagestandardmet percentagestandardmetandabove percentagestandardnearlymet percentagestandardnotmet meanscalescore area1percentageabovestandard area1percentagenearstandard area1percentagebelowstandard area2percentageabovestandard area2percentagenearstandard area2percentagebelowstandard area3percentageabovestandard area3percentagenearstandard area3percentagebelowstandard area4percentageabovestandard area4percentagenearstandard area4percentagebelowstandard{
    encode `v', gen(new`v')
    drop `v'
    rename new`v' `v'
}
**looking at gender average passing rates
sum percentagestandardmetandabove if schoolcode==0 & subgroupid==3
**38% Male passing rate
sum percentagestandardmetandabove if schoolcode==0 & subgroupid==4
**43% Female passing rate
gen female=1 if subgroupid==4
replace female=0 if subgroupid==3
replace female=. if subgroupid!=3 & subgroupid!=4
ttest percentagestandardmetandabove, by(female)
**females have a significantly higher passing rate than males
**Passing rates by disadvantaged 
gen disadvantaged=1 if subgroupid==31
replace disadvantaged=0 if subgroupid==111
ttest percentagestandardmetandabove, by(disadvantaged)
**Disadvantaged schools score more then 24% lower on average!!
**Generating Variables for subgroups: Aggregate Races  
gen africanam=1 if subgroupid==74
replace africanam=0 if subgroupid==75 | subgroupid==76 | subgroupid==77| subgroupid==78 | subgroupid==79 | subgroupid==80| subgroupid==144
gen alaskan=1 if subgroupid==75
replace alaskan=0 if subgroupid==74 | subgroupid==76 | subgroupid==77| subgroupid==78 | subgroupid==79 | subgroupid==80| subgroupid==144
gen asian=1 if subgroupid==76
replace asian=0 if subgroupid==74 | subgroupid==75 | subgroupid==77| subgroupid==78 | subgroupid==79 | subgroupid==80| subgroupid==144
gen filipino=1 if subgroupid==77
replace filipino=0 if subgroupid==74 | subgroupid==75 | subgroupid==76 | subgroupid==78 | subgroupid==79 | subgroupid==80| subgroupid==144
gen hispanic=1 if subgroupid==78
replace hispanic=0 if subgroupid==74 | subgroupid==75 | subgroupid==76 | subgroupid==77 | subgroupid==79 | subgroupid==80| subgroupid==144
gen islander=1 if subgroupid==79
replace islander=0 if subgroupid==74 | subgroupid==75 | subgroupid==76 | subgroupid==78 | subgroupid==77 | subgroupid==80| subgroupid==144
gen white=1 if subgroupid==80
replace white=0 if subgroupid==74 | subgroupid==75 | subgroupid==76 | subgroupid==78 | subgroupid==79 | subgroupid==77| subgroupid==144
gen tworace=1 if subgroupid==144
replace tworace=0 if subgroupid==74 | subgroupid==75 | subgroupid==76 | subgroupid==78 | subgroupid==79 | subgroupid==80| subgroupid==77
**Subgroup Disadvantaged Race
gen africanam_d=1 if subgroupid==200
replace africanam_d=0 if subgroupid==201 | subgroupid==202 | subgroupid==203 | subgroupid==204 | subgroupid==205 | subgroupid==206| subgroupid==207
gen alaskan_d=1 if subgroupid==201
replace alaskan_d=0 if subgroupid==200 | subgroupid==202 | subgroupid==203 | subgroupid==204 | subgroupid==205 | subgroupid==206| subgroupid==207
gen asian_d=1 if subgroupid==202
replace asian_d=0 if subgroupid==201 | subgroupid==200 | subgroupid==203 | subgroupid==204 | subgroupid==205 | subgroupid==206| subgroupid==207
gen filipino_d=1 if subgroupid==203
replace filipino_d=0 if subgroupid==201 | subgroupid==202 | subgroupid==200 | subgroupid==204 | subgroupid==205 | subgroupid==206| subgroupid==207
gen hispanic_d=1 if subgroupid==204
replace hispanic_d=0 if subgroupid==201 | subgroupid==202 | subgroupid==203 | subgroupid==200 | subgroupid==205 | subgroupid==206| subgroupid==207
gen islander_d=1 if subgroupid==205
replace islander_d=0 if subgroupid==201 | subgroupid==202 | subgroupid==203 | subgroupid==204 | subgroupid==200 | subgroupid==206| subgroupid==207
gen white_d=1 if subgroupid==206
replace white_d=0 if subgroupid==201 | subgroupid==202 | subgroupid==203 | subgroupid==204 | subgroupid==205 | subgroupid==200| subgroupid==207
gen tworace_d=1 if subgroupid==207
replace tworace_d=0 if subgroupid==201 | subgroupid==202 | subgroupid==203 | subgroupid==204 | subgroupid==205 | subgroupid==206| subgroupid==200
**subgroup not disadvantaged race
gen africanam_nd=1 if subgroupid==220
replace africanam_nd=0 if subgroupid==221 | subgroupid==222 | subgroupid==223 | subgroupid==224 | subgroupid==225 | subgroupid==226| subgroupid==227
gen alaskan_nd=1 if subgroupid==221
replace alaskan_nd=0 if subgroupid==220 | subgroupid==222 | subgroupid==223 | subgroupid==224 | subgroupid==225 | subgroupid==226| subgroupid==227
gen asian_nd=1 if subgroupid==222
replace asian_nd=0 if subgroupid==221 | subgroupid==220 | subgroupid==223 | subgroupid==224 | subgroupid==225 | subgroupid==226| subgroupid==227
gen filipino_nd=1 if subgroupid==223
replace filipino_nd=0 if subgroupid==221 | subgroupid==222 | subgroupid==220 | subgroupid==224 | subgroupid==225 | subgroupid==226| subgroupid==227
gen hispanic_nd=1 if subgroupid==224
replace hispanic_nd=0 if subgroupid==221 | subgroupid==222 | subgroupid==223 | subgroupid==220 | subgroupid==225 | subgroupid==226| subgroupid==227
gen islander_nd=1 if subgroupid==225
replace islander_nd=0 if subgroupid==221 | subgroupid==222 | subgroupid==223 | subgroupid==224 | subgroupid==220 | subgroupid==226| subgroupid==227
gen white_nd=1 if subgroupid==226
replace white_nd=0 if subgroupid==221 | subgroupid==222 | subgroupid==223 | subgroupid==224 | subgroupid==225 | subgroupid==220| subgroupid==227
gen tworace_nd=1 if subgroupid==227
replace tworace_nd=0 if subgroupid==221 | subgroupid==222 | subgroupid==223 | subgroupid==224 | subgroupid==225 | subgroupid==226| subgroupid==220

**Look at disadvantaged students only
preserve
drop if disadvantaged!=1
sort percentagestandardmetandabove
**A lot of schools have 0 disadvantaged children passing the exam
**the highest has 92% passing! 
restore

**Race specific student analysis
**Compare African American students to all other races
ttest percentagestandardmetandabove, by(africanam)
**About 15% fewer African American students pass over all
**Compare Hispanic Students to all other races
ttest percentagestandardmetandabove, by(hispanic)
*more than 20% fewer hispanic students pass! 
**Compare white students to all other races
ttest percentagestandardmetandabove, by(white)
**10% more pass

*Compare disadvantaged students by race
**Compare white disadvantaged to all other disadvantaged students
ttest percentagestandardmetandabove, by(white_d)
**5% more White disadvantaged students pass than other disadvantaged
ttest percentagestandardmetandabove, by(africanam_d)
**6% fewer african american disadvantaged students 
ttest percentagestandardmetandabove, by(hispanic_d)
**hispanic disadvantaged students have the lowest (10%) pass rate of all disadvantaged students 

**generate variables to isolate disadvantaged/advantaged of the same race
gen africanam_dis=1 if subgroupid==200
replace africanam_dis=0 if subgroup==220
ttest percentagestandardmetandabove, by (africanam_dis)
**13% lower pass rate for disadvantaged aa students
gen hispanic_dis=1 if subgroupid==204
replace hispanic_dis=0 if subgroup==224
ttest percentagestandardmetandabove, by (hispanic_dis)
**almost 20% lower pass rate
gen white_dis=1 if subgroupid==206
replace white_dis=0 if subgroup==226
ttest percentagestandardmetandabove, by (white_dis)
**26% lower pass rate for disadvantaged white students!!

**summary stats by grade
tab grade, sum( percentagestandardmetandabove)
preserve 
drop if disadvantaged!=1
tab grade, sum( percentagestandardmetandabove)
*differing pass rates do not seem to be due to different grade levels. It looks like 6th graders have the lowest pass rate, but all grades are nearly the same.

tabstat percentagestandardmetandabove, by(schoolname)


**regression models
reg percentagestandardmetandabove disadvantaged studentswithscores grade i.countycode
**larger schools do not have a higher rate of passing. Even though grade increases lead to significantly smaller percentages of passing, it is only by less than half of a percent. We can see that being disadvantaged has the largest negative impact in this model.
reg percentagestandardmetandabove africanam studentswithscores grade i.countycode
reg percentagestandardmetandabove hispanic studentswithscores grade i.countycode
reg percentagestandardmetandabove asian studentswithscores grade i.countycode
reg percentagestandardmetandabove hispanic_d studentswithscores grade i.countycode
**All regressions show the same pattern we say in the original ttest models. Further investigation into controls should be done


**Randomization process
preserve
*Drop state aggregate
drop if schoolcode==0
**Disadvantaged elementary schools only
drop if grade>5
drop if disadvantaged!=1
sort percentagestandardmetandabove
**Drop schools that have more than a 0 passing rate**
keep in 1/212
**212 schools have 0 passing disadvantaged elementary school students. 
**Now specify 4th grade
drop if grade!=4
**62 fourth grade schools have 0 pass rate
**generate randomization variable
generate random = runiform()
sort random
**Selected the school randomly listed frst: John D Sloat Elementary, Sacramento
restore
preserve
drop if schoolcode==0
**Select a low scoring high school
drop if grade<11
drop if disadvantaged!=1
sort percentagestandardmetandabove
**Drop schools that have more than a 0 passing rate**
keep in 1/1069
generate random = runiform()
sort random
**Randomly selected Twin Palms Continuation, Riverside
restore
preserve
**Choosing a top performing 4th grade
drop if schoolcode==0
drop if disadvantaged!=1
drop if grade!=4
xtile decile= percentagestandardmetandabove, n(10)
sort percentagestandardmetandabove
**Drop those not in the top decile
drop if decile<10
generate random = runiform()
sort random
**randomly select Highland Grove Elementary, San Bernadino 92346
restore
preserve
**Randomly selecting a 7th grade top performing
drop if schoolcode==0
drop if disadvantaged!=1
drop if grade!=7
xtile decile= percentagestandardmetandabove, n(10)
sort percentagestandardmetandabove
drop if decile<10
generate random = runiform()
sort random
**Discovery, LA, CA randomly selected
restore
preserve
**Select a top performing high school
drop if schoolcode==0
drop if disadvantaged!=1
drop if grade!=11
xtile decile= percentagestandardmetandabove, n(10)
sort percentagestandardmetandabove
drop if decile<10
generate random = runiform()
sort random
**Downtown Business High School 
restore
