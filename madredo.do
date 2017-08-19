rename cash_choice choice0
rename child_choice choice1
drop if choice1==.
drop if female==.
label define female 0"Male" 1"Female"
gen gender="Female" if female==1
replace gender="Male" if female==0
gen edu=primary+secondary+technical+university
gen confidence=torneo_score-competitor
*summary stats
sum age 
sum age if female==1 
sum age if female==0
ttest age, by(female)
sum paid_job
sum paid_job if female==1
sum paid_job if female==0
ttest paid_job, by(female)
sum edu
sum edu if female==1
sum edu if female==0
ttest edu, by(female)
sum choice0
sum choice0 if female==1
sum choice0 if female==0
ttest choice0, by(female)
sum choice1
sum choice1 if female==1
sum choice1 if female==0
ttest choice1, by(female)
ttest choice0, by( forced_discplaced)
ttest choice1, by( forced_discplaced)
sum piece_score
sum piece_score if female==1
sum piece_score if female==0
ttest piece_score, by (female)
*significant difference in male and female scores in the base round
sum torneo_score
sum torneo_score if female==1
sum torneo_score if female==0
ttest torneo_score, by (female)
*significant difference in male and female scores in tournament round
sum cash_score
sum cash_score if female==1
sum cash_score if female==0
ttest cash_score, by (female)
sum child_score
sum child_score if female==1
sum child_score if female==0
ttest child_score, by (female)
sum risk
sum risk if female==1
sum risk if female==0
ttest risk, by(female)
sum confidence
sum confidence if female==1
sum confidence if female==0
ttest confidence, by(female)
sum wtp_child
sum wtp_child if female==1
sum wtp_child if female==0
ttest wtp_child, by(female)
*Checking for balance in Forced Displacement
ttest torneo_score, by (forced_discplaced)
*no significant score difference under tournament for forced displaced subsample
ttest piece_score, by (forced_discplaced)
*displaced actually score significantly lower in the base round and still compete more
*simple regressions
probit choice0 female
outreg using cash.doc, replace
probit choice0 female torneo_score
outreg using cash.doc, merge
probit choice0 female torneo_score risk
outreg using cash.doc, merge
probit choice0 female torneo_score risk confidence
outreg using cash.doc, merge
probit choice0 female torneo_score risk confidence, fe(session)
outreg using cash.doc, merge
probit choice1 female
probit choice1 female torneo_score
probit choice1 female torneo_score risk
probit choice1 female torneo_score risk confidence
probit choice1 female torneo_score risk confidence wtp_child
probit choice1 female torneo_score risk confidence, fe(session)
*set up long form panel 
reshape long choice, i(id) j(treatment)
label define treatment 0"cash" 1"child" 
label value treatment treatment 
xtset id treatment 
xtreg choice treatment 
gen fem_voucher= female*treatment
*base regressions
xtreg choice treatment female fem_voucher
xtprobit choice treatment female fem_voucher
*control for score
xtreg choice treatment female fem_voucher piece_score
xtprobit choice treatment female fem_voucher piece_score
*score is significantly determining their willingness to compete
*control for age, and employment
xtreg choice treatment female fem_voucher age paid_job
xtprobit choice treatment female fem_voucher age paid_job
*add hh gender
xtreg choice treatment female fem_voucher age paid_job headhh_female
xtprobit choice treatment female fem_voucher age paid_job headhh_female
*add risk
xtreg choice treatment female fem_voucher risk
xtprobit choice treatment female fem_voucher risk
xtreg choice treatment female fem_voucher age paid_job headhh_female risk
*add wtp
xtreg choice treatment female fem_voucher risk wtp_child
xtprobit choice treatment female fem_voucher risk wtp_child
xtreg choice treatment female fem_voucher age paid_job headhh_female risk wtp_child
xtprobit choice treatment female fem_voucher age paid_job headhh_female risk wtp_child
*random effects
xtprobit choice treatment female fem_voucher age paid_job headhh_female risk wtp_child, re
*alternative wtp method for robustness
xtprobit choice treatment female fem_voucher age paid_job headhh_female risk tiendauseful, re
*with displacement 
xtreg choice treatment female fem_voucher age paid_job headhh_female forced_discplaced risk wtp_child, re
xtprobit choice treatment female fem_voucher age paid_job headhh_female forced_discplaced risk wtp_child, re
*forced displacement significent and with a large coefficient
