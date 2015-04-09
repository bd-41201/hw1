# Items to Explore

### Question 1
What would be interesting for us to know from a business perspective, say if we were working for Ben and Jerry's:
<ol>
  <li>What are the factors that describe the customer (age, race, marital status, etc)?</li>
  <li>
    <ul>
      <li>Predominately white, non-hispanic</li>
      <li>60% are married</li>
      <li>~73% have no kids under 18</li>
      <li>Most male and female head of household are 45-64 years old</li>
      <li>High income - largest bucket is $70k - $100k household income</li>
    </ul>
  </li>
  <li>What factors make people pay more for ice cream?</li>
  <li>Do we really need two sizes of packaging? Or could we make more money selling only one size?</li>
  <li>What share of people use coupons? Do they end up paying less?</li>
</ol>

### Question 2
The regression model in the code `benjerry_start.r` uses the following variables as regressors:
<ul>
  <li>Size of container purchased (16 or 32 ML OZ)</li>
  <li>Household income</li>
  <li>Household size</li>
  <li>Flavor description (flavor_descr) with Vanilla (VAN) as the base case</li>
  <li>A categorical variable 'usecoup' that represents whether a coupon was used in the purchase</li>
  <li>A calculated variable 'couponper1' that represents the value of the coupon divided by the number of containers bought</li>
  <li>A categorical variable representing the region of the US (East, South, Central, West)</li>
  <li>A categorical variable representing whether the purchaser is married</li>
  <li>...</li>
</ul>

### Question 3
