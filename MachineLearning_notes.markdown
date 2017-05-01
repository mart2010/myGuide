
These notes are taken following my own experimentation, some books and courses taken on Machine Learning.  T

# Multivariate Linear Regression

## Gradient Descent Methods

*Gradient descent*: algorithm used for finding parameter values where Cost/Error function reaches a minimum. It may be that this minimum is local but the goal is to find **global** minimum.  We first initialize the parameters at a starting point (any point) and keep iterating toward the direction of largest slope by re-assigning current point to the new location. Even when Cost function has an exact analytical solution (ex. SSE squared errors), this technique may still be preferable for performance reasons.
The exact analytical solution are guaranteed to find a global minimum but may be quite expensive to calculate.  And more commonly, the Gradient descent algorithm is mandatory as no analytical solution exist for the minimization of Cost function (ex. logistic equation for classification problems).  

A useful intuition about Gradient descent is the blind interpretation: imagine a blind (i.e. have no idea on the function form to minimize) who wish to find the lowest point.  With this algo, this minimum is found as we keep going toward the greatest descent around the vicinity of our current position...  

The general equation of Gradient descent is:

new-x<sub>i</sub> = pre-x<sub>i</sub> + rate * diff( C(params) ) / d(param1)   (where diff() is the partial derivation or gradient of the cost function with respect to param<sub>i</sub>)
from feature x1 to feature xm.

...all features coordinate x<sub>i</sub> being calculation simultaneously.


### Feature Scaling

To allow Gradient Descent to converge faster on multi-variate problem, we should scale and mean-normalize each variables xi as:

scale-xi = (xi -ui) / s

s could be (range of xi),
or yet we could normalize ( substract mean and divide by std dev of xi):
norm-xi = (xi - ui) / std-dev(xi)

This is done to avoid having highly skewed contour lines of the cost function J(theta), i.e. stretched in directions of feature with smallest values-range (since these must be associated with larger param values to contribute in same way as features having larger values).  The cost function is the one we are looking for the global minima).


NOTE: this scaling is not necessary when using the normal equation (ie finding theta = (XtX)-1 Xt Y ) which gives the analytical solution in one-step to the minimization problem.  


### Learning Rate

To find the optimal *learning rate* alpha, the easiest is to plot the Cost function J(theta) against the nb of iteration.  The rate alpha should neither be too small (very low convergence), nor too big (may not decrease on every step or worst may no convergence as it will overshoot).  A simple heuristic, is to use small value (eg. 0.001) and increase by a factor of 3 each time (i.e. log-scale as we multiply by 3 from previous values until we converge in an optimal way:   0.01, 0.03, 0.1, 0.3, 1, etc..).


### Categorical Attributes and transformation

When we transform feature with categorical values, we should having a direct mapping to to numerical value.  This carries ordering and distance properties that are not intrinsic to categorical values (ex. occupation A --> value x ,... creating numerical feature introduces relationships between categories that don’t otherwise exist.)

A different idea is to use One-Hot-Encoding (OHE), where we create dummy feature for every categorical values of every categorical features.  These dummy feature don't introduce spurious relationship.  

These lead to very sparse data structure, so usually a Sparse representation is used where only the index/values for non-zero dummy features are kept.


## Normal Equation Method

This method involves solving analytically the Theta params, using algebra/calculus derivation.  This leads to the famous solution form:

theta (vector)  = (X^t X)-1 * X * Y  (where X is our m-observation X n-features matrix).

Very rarely the invert of (X^t)X may give a degenerate matrix (none invertible), this can happen :
1) there is linear dependency among two or more chosen features
2) when n > m, less observations than the # of features (variables)  

Then, we can 1) remove linear dependency among variables , 2)  delete some variables or use regularization (to be covered later)

the use of Octave pinv() function will work either way, as it does a pseudo-inverse when Xt X is not invertible.


Pro/Cons:

Normal Equation:
  * (+) no need to define any step parameter=alpha
  * (+) no worry about the number of iterations (somewhat more unpredictable convergence time)
  * (-) the inverse matrix calculation (O(n^3)) becomes quite expansive when n (nb of features > 10'000 ).  

Gradient Descent:
  * (+) Can still scale with very large number of features, ex.  n can be 10^6 !
  * (+) is also more versatile as it can be used in other context where Normal Equation can't work (ex. Logistic regression)




# Classification

The objective of classification is to learn a 2-class y variable (binary) using a set of predictors or input variables xs.  It is useful to define y E {0,1) with 0:negative and 1: positive.

## Logistic Regression


If we use the regular cost function Cost (h(x), y) = 1/2 ( h(x) - y )^2 (SSE), where h(x) is our hypothesis fct parametrized by theta, wWith Logistic regression, then because h(x) is non-linear (sigmoid: 1 / (1 + exp(-theta' x)) it means its form will NOT be convex (unlike linear regression which is always well ..linear along the params theta no matter how complex we chose the polynomial to be..)!  No we cannot find analytically its global minimum (its shape will be formed of multitudes valleys and bump...).

To minimize the J(theta) = SUM Cost() (over all points), we need a different Cost() fct having a convex shape to be able to use, for ex., Gradient Descent.

To avoid this, we come up with a diff Cost fct :
Cost(h(x),y) = -log(h(x) if y=1 and = -log(...).


The idea is to define a particular  Cost fct that will avoid the non-convex optimization issue when finding a global minimum of J(theta)! And avoiding to have many local minima perturbing the greatest descent.  

The new Cost function will always converge and find the global minimum point!  This Cost function can be obtained by using the Max Likelyhood of h(x) parametrized by theta, and the cost fct will be the same as the minimum equivalent of the MLE estimate of theta...

Now, with Cost function, we can see that the Gradient Descent algo will be identical as for lin. regression (but h(x) being of a different form).

Feature scaling also apply to optimize the Gradient Descent of logistic regression.      


## Regularization

This is one technique used to reduce over-fitting.

Under-fitting (i.e. high bias) for ex., our model fails to recognize the problem is not linear but our algo has a very strong bias or preconception and insist on fitting a simple lin. function that can only under-fit (despite the data ).

Over-fitting (i.e. high variance), we use too many parameters for the dataset size at hand so the learning hypothesis set can vary (high-variance) to fit data pretty closely, but will fail to generalize.

Also, adding many new features gives us more expressive models which are able to better fit our training set. But If too many new features are added, this can lead to overfitting of the training set.  This is especially true when the new features come from existing ones (different degree ex. x1^2, x1^3, or yet cross-product term  x1x2 , ..) : i.e. creating polynomial terms up to a given power degree!!!

Techniques to address over-fitting:
1- reduce # of features (manually, or through model selection algo.)  drawback: lose some potential info.
2- regularization:   Keep all features, but reduce magnitude or param theta values. Works well when we have many features and each contribute a bit to predicting y.

Regularization adds a penalizing param theta1 to n (not o) tot the Cost function J(theta).


**Ridge regression**

This refers to regression when we add Regularization term to limit model's complexity.   To control the importance of this term, we must add a free parameter:  lambda.   These sort of free parameters are sometimes called hyperparameters!  

To find the best lambda, we must use a Validation set where we test many different values for lambda and choose the one yielding smallest validation error over the set.  Finding these is sometimes referred to "Grid Search": exhaustively search through hyperparameters space:
	  * define and discretize search space (linear or log scale) for lambda  (ex. 10e-8, 10e-6, 10e-4, 10e-2, 1)
	  * evaluate points via the validation error
	  * a 2 hyperparameters test (with 5 values each) would imply training 5^2 model and test them.  



# Advice for applying Machine Learning

Let's say we have trained a Regularized Regression model, and we find out our hypothesis performs very badly in predicting new/unseen instance.  There are many options to try improving its predictive capability:
	1) get more training examples could be costly in time and not so helpful…)
		--this can only fix "high variance" regime
	2) try smaller set of features
		--this can only fix "high variance" regime
	3) try getting additional features
		--this may help fix "high bias" regime
	4) try adding polynomials features (x1x2, x1^2, x2^2, etc..)
		--this as well may fix "high bias" regime
	5) try decreasing regularised parameter lambda
		--this fixes "high bias" regime
	6) "   increasing  "            "          "
		--this fixes "high variance" regime

 A lot of time, people simply use "gut feeling" approach and ended up spending lots of effort and time.  There is a better approach called "pronostic"

1) First how to evaluate our hypothesis?
One approach is to split my examples into a training set (ex. 70%) and a test set (ex. 30%) at random.  Then use this test set to evaluate the perf of my hypothesis function, using the Cost function (ex. squared error for regression…, normal Cost for logistic, or alternatively a misclassification error fit).

2) how to prevent over-fitting and under-fitting
     Let's say I want to decide which degree polynomial to use for my features (call it parameter d)?  These sort of problems are referred to as **Model Selection**.   

If I evaluate each hypothesis using the test set and choose the one that perform best on this test set, then this corresponds to fitting the parameter d to my test set (the same way the param Theta's were fit to my training set).  So once I've chosen the best hypothesis set in this manner, how can I evaluate its predictive error, against new/unseen data? Could I use the perf error on the test set, NO since the parameter d was fit to this, so it is likely to performed more poorly on new data.  The best way to avoid this, is to define a 3rd set called "cross-validation" and use this set to choose our best hypothesis.  Then we can use the test set to evaluate future pert. of our hypothesis.   

The same methodology can be used for choosing the best hypothesis with **regularization**… when we evaluate the error in cross-validation/test we don't consider the regular. param lambda since we want to have the real error.  So we find the best Theta's at each different value of lambda, and choose best hypothesis, i.e. the one having the minimum error in Cross-validation.

Also, if we want to know whether we are under "high bias" (underfit) or "high variance" (over fit) regime, we can compare the difference in pert Error for training vs cross-validation:
	1) if both are high then we have a high bias issue
	2) if training error is small but cross-validation is high, then we have a high variance.

This sort  of Plot s called :  **Learning Curves** !!
Learning curve: plot error metric (ex. SSE) in function of m (# of training ons used)


In high-bias regime, then getting more training data will not (by itself) help much (we are under fitting, so more points cannot help reduce this).  

In high-variance regime, getting more data is likely to help.




# System design

--recommended to start small (less sophisticated but quickly running)
--then plot learning curve for this simple learning hypothesis (help you decide if you need more data, more features, etc..)
--Error analysis: check out the mis-classified instance (from cross-validation set), and see if we can spot any systematic trend in the types of instance mis-classified.

--to try out many new ideas and compare many diff hypothesis, it is much better to have a single metric for evaluation criteria, ex. Cross-validation Error rate!


Be careful with SKEWED CLASSES!

(ex. 1% classification error on predicting cancer on a dataset with only 0.5% positive cancer!   Then we need a different error metric.  Ex. Precision/Recall  :

This uses the evaluation matrix (sometimes called confusion).

Precision = True positives / #Predicted positive =  True positive / (True positive + False positive)

 (taken among the instances classified as positive, what fraction were really positive)

Recall = True positive / Actual Positive = True positive / (True positive + False negative)
    (among all positive instance how many were correctly classified as positive)

So now we measure how good is our algo based on both Precision and Recall!   A very good will have high Precision rate and high recall.

We can after play with the prob threshold (ex. for a logistic regression), and increase/decrease precision while decrease/increase recall.  We can draw precision against recall. But we are much better off with a single evaluation number… so the best is to transform recall + precision metrics into the Fscore = 2 (PxR)/(P+R) (or called F1 score), one of many metrics possible to use, but average is certainly not one of these!  (where both metrics need to have good value to get good F score)



# SUPPORT VECTOR MACHINE

SVM cost function is similar to Logistic regression, replacing the sigmoid form with a hinge form  (hinge loss, is flat+linear, where cost=0) for points well classified and cost increasing linearly with distance when badly classified.

The SVM optimization objective yield a term for minimizing fct parameter Theta's values (sum of sq).  This term, can be
comparable to the regularization term as defined with other learning methods.

SVM does NOT produce a probability (as opposed to LR), it only provide the class based on theta' X > 1 or X < -1.

Kernels:  For non-linear separable case, we can build new feature by creating "landmark" points within the input data
domain, and derive the similarity's of our observation with these landmarks l's.  Similarity can be calculated in various
form, but a popular way is to use the distance between landmark and point and apply:  exp( ||x-l||2 / 2sigma^2) .

Now, the next step is to consider all points to become landmark, so that we end up with a input z in m-dimension space
(where m=# of obs).




# DIMENSIONALITY REDUCTION


Useful for:

  1. Data compression (eliminate features highly correlated and diminish redundancy).  
  2. Data visualisation (to show 2-D or 3-D view of data)

PCA is one such good technique.  It shrinks down the input space from n to k, where k is choosen by % of variance retained.  For ex, we can go from n > 10'000 to k < 1000 is possible without loosing much variance!

In 1, it help speed-up supervised learning process, especially when feature var are in very high dimen  and in general it will help relieve the memory/cpu needs.   

PCA transform our feature vector x in space=n into a new transformed z feature vector in space=k (note: the target y-abel var is not considered during the PCA tranformed).


The PCA should only be run onto the training set... so the param discovered like U, etc.. should not fit your valid/test set.  Once you know the PCA mapping from x--> z, you can apply it for new x (and xi in the valid/test set)  


Bad usage :  used to prevent overfitting (not good), since PCA throws away the y target variable.  

Advice: you should try to process on full space of data (raw) before reducing it with PCA.  If you face issues (too slow, do not fit in memory, etc.) then try PCA>

PCA assumptions about linearity and orthogonality is not always appropriate.  Alternative approach is used when different assumptions is needed is that data (ex. manifold learning, kernel PCA, ICA).

Centering the data is crucial (zero mean) and rescaling (so that variance is not determined by choice of  unit of measurement) are necessary pre-processing steps.  



# ANOMALY DETECTION

This is often done by modeling p(x) from "normal" observations and test whether p(xt) < epsilon for a test observation
xt, where *epsilon* is the smallest value we want for p(x) to classify an obs as  an nomaly. (ex.  < 0.02) ... not the
same as the prob of x, since x are continuous variables!

Modeling simplification:
p(x) model is estimated by assuming all feature xi are independent and all folow a Gaussian prob fct (to be checked with
histogram, otherwise apply some transformation.. like a log-transform (long right-tail) or x^1/3 etc..).  So the prob
density is simply the product of each var. density: p(x) = p(x1; mean1,var1) x
p(x2;mean2,var2) x ...

Contrast between using indep. model vs multivariate model:
Use indep:
   * If you can create feature from exisintg one to capture correlation (ex. CPU/Memory)
   * Ok when #of obs is small

Use multivariate:
   * when dataset has correlation, this model captures it automatically (no need to create derived features)
   * computationnally more expensive (inverse of sigma..)  
   * need more data as we have more parameters estimate (n^2 /2 for the sigma covar matrix), so m>>n (n=#of var)


When independence assumption fails (correlation exist), we should try model a Multivariate Gaussian distribution instead...(with a
covariance matrix sigma).

The algo evaluation is done by splitting a training set (with only the "normal" observations) and a validation and test
set that will include some anomaly cases.  Then we use an evaluation metric to measure the perf of our model (ex.
Precision/Recall or F1-score... i.e. one
suitable for skewed dataset...which is what anomaly is all about!! ) and
set the *epsilon* yielding the best perf against validation set.

When to use Supervised algo vs Anomaly detection, as both have a target variable (y=0 normal, y=1 anomaly):

______________________________________________________
| Anomaly detection        |   Supervised learning  |
|--------------------------|------------------------|
| very small positive      | balanced nb of ex.     |
| ex (y=1) vs y=0          |                        |
| many diff. "types" of    |                        |
| anomalies.. hard for algo| Enough positive ex.    |   
| to learn these           | to let the algo learn  |
|  ex:                     | ex.                    |
| - fraud detection        | - Email spam classifier|
| - manufacturing (engine) | - weather prediction   |
| - monitor machines in    | - cancer classification|
|   data center            |                        |
-----------------------------------------------------
