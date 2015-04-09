#### Purchases of Ben and Jerry's Ice Cream
benjer = read.csv("BenAndJerry.csv")

## explore a bit
names(benjer)

## create a new variable for price per unit
priceper1 = (benjer$price_paid_deal + benjer$price_paid_non_deal)/benjer$quantity
y <- log(1+priceper1)

## grab some covariates of interest
## we'll create a properly formatted data.frame
x <- benjer[,c("flavor_descr","size1_descr",
	"household_income","household_size")]

## relevel 'flavor' to have baseline of vanilla
x$flavor_descr <- relevel(x$flavor_descr,"VAN")
## coupon usage
x$usecoup = factor(benjer$coupon_value>0)
x$couponper1 <- benjer$coupon_value/benjer$quantity
## organize some demographics
x$region <- factor(benjer$region,
	levels=1:4, labels=c("East","Central","South","West"))
x$married <- factor(benjer$marital_status==1)
x$race <- factor(benjer$race,
	levels=1:4,labels=c("white","black","asian","other"))
x$hispanic_origin <- benjer$hispanic_origin==1
x$microwave <- benjer$kitchen_appliances %in% c(1,4,5,7)
x$dishwasher <- benjer$kitchen_appliances %in% c(2,4,6,7)
x$sfh <- benjer$type_of_residence==1
x$internet <- benjer$household_internet_connection==1
x$tvcable <- benjer$tv_items>1

## combine x and y, just to follow my recommended `way to use glm'
## cbind is `column bind'.  It takes two dataframes and makes one.
xy <- cbind(x,y)

## fit the regression
fit <- glm(y~., data=xy)

## grab the non-intercept p-values from a glm
## -1 to drop the intercept, 4 is 4th column
pvals <- summary(fit)$coef[-1,4]

## source the fdr_cut function
source("/Users/tbesio/Desktop/BD 41201/Utility Scripts/fdr.R")

### Generate some plots for question 1
## Customer Breakdown by Race
# png('benjerry_race.png')
# qplot(xy$race) + bar_graph_theme + scale_y_continuous(expand = c(0,0))
# dev.off()

## Breakdown of race==white
# png('white_breakdown.png')
# qplot(x=c("White Non-Hispanic","White Hispanic"),y=white_breakdown,xlab='',ylab='Count') +
# bar_graph_theme + geom_bar(stat="identity") + scale_y_continuous(expand = c(0,0))
# dev.off()

## Married?
# png('benjerry_married.png')
# qplot(xy$married,xlab='Married?',ylab='Count') + bar_graph_theme + scale_y_continuous(expand = c(0,0))
# dev.off()
# sum(xy$married==TRUE)/length(xy$married)
# [1] 0.6041686

## Have kids?
# sum(benjer$age_and_presence_of_children==9)/length(benjer$age_and_presence_of_children)
# [1] 0.7256303
# ~73% have no kids under 18

## Age?
# Male head age
# hist(benjer$age_of_male_head)
# For those with a male head of household, most are 45-64 years old
# Female head age
# hist(benjer$age_of_female_head)
# Same range for women.

## Income level?
# hist(benjer$household_income)
# $70k - $100k

## Popular Flavors?
# png('benjerry_flavor.png')
# qplot(xy$flavor_descr,xlab='Flavor',ylab='Count') + bar_graph_theme +
# theme(axis.text.x = element_text(angle=75,hjust=1.0,size=6.5)) + scale_y_continuous(expand = c(0,0))
# dev.off()
# round(summary(xy$flavor_descr)/sum(summary(xy$flavor_descr)),2)
# Cherry Garcia is the most popular with 10% of sales.
