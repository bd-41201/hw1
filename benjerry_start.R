#### Purchases of Ben and Jerry's Ice Cream
(benjer = read.csv("BenAndJerry.csv"))

## explore a bit
names(benjer)

## create a new variable for price per unit
priceper1 = (benjer$price_paid_deal + benjer$price_paid_non_deal)/benjer$quantity
y <- log(1+priceper1)

## grab some covariates of interest
## we'll create a properly formatted data.frame
x <- benjer[,c("flavor_descr","size1_descr","household_income","household_size")]

## relevel 'flavor' to have baseline of vanilla relevlling flavor discription to serve Vanilla as base
x$flavor_descr <- relevel(x$flavor_descr,"VAN")
## coupon usage adding factor/categorical attributes to logical values
x$usecoup = factor(benjer$coupon_value>0)
x$couponper1 <- benjer$coupon_value/benjer$quantity
## organize some demographics converting from int to level and labeling
x$region <- factor(benjer$region, 
	levels=1:4, labels=c("East","Central","South","West"))
##converting from int to level and labeling
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
source("fdr.R")


## BoxPlot:Are People Paying Less When Using Coupons
## boxplot(priceper1~x$usecoup, main="Are People Paying Less When Using Coupons?", xlab = "Did They Use A Coupon?", ylab = "How Much Did They Pay Per Purchase?")

## BoxPlot:Are People Paying The Same in Different Regions?
## boxplot(priceper1~x$region, main="Are People Paying The Same In Different Regions?", xlab = "What Region Are They From?", ylab = "How Much Did They Pay Per Purchase?")

## BoxPlot:Do Married People Pay More Per Purchase Than Single People?
## boxplot(priceper1~x$married, main="Do Married Individuals Pay More Per Purchase Than Single Individuals?", xlab = "Are They Married?", ylab = "How Much Did They Pay Per Purchase?")

## Boxplot: How Does Household Income Affect Price Per Purchase?
## boxplot(priceper1~x$household_income, main="How Does Household Income Affect Price Per Purchase?", xlab = "What Is Their Household Income?", ylab = "How Much Did They Pay Per Purchase?")

## Histogram of PVALS
## hist(pvals, breaks=20)
