Class 07: Machine Learning 1
================
Tomi Lane Timmins

In this class, we will explore clustering and dimensionality reduction
methods.

## K-means

(K is number of clusters - number of groups that you want. In k
clustering, we provide k.)

Make up some input data where we know what the answer should be.

SIDENOTE: rnorm() - if you input 10, it will give you 10 points, all
centered around 0. (only input is n and n = \# observations we want)

``` r
rnorm(10)
```

     [1]  0.70058372  1.16099306  1.02988002 -2.44286367  1.04209072 -0.09920425
     [7] -1.12068992 -0.76318455 -1.69979317  0.36804100

If we make a histogram of rnorm(),it gives a standard distribution

``` r
hist(rnorm(10000))
```

![](Class07_files/figure-commonmark/unnamed-chunk-2-1.png)

You can change where it centers (one of the inputs is mean (default 0):

``` r
rnorm(30, -3)
```

     [1] -3.389301 -4.236047 -2.397064 -3.208129 -3.429117 -3.533235 -3.110542
     [8] -2.051569 -2.573697 -3.064937 -3.592735 -2.434025 -2.799500 -2.111810
    [15] -3.833357 -3.910970 -4.437266 -1.921680 -3.274250 -1.365552 -3.263205
    [22] -4.205435 -3.235895 -2.513222 -1.767111 -2.909576 -2.861514 -3.045978
    [29] -4.013730 -2.235810

Back to making up data:

``` r
tmp <- c( rnorm(30, -3), rnorm(30, 3) )
# cbind binds together two columns:  the rev(dataset) (reverses the direction of the data provided (from 3 --> -3)) and the dataset (-3 -->3) 
x <- cbind(x = tmp, y = rev(tmp))
head(x)
```

                 x        y
    [1,] -2.434507 3.344175
    [2,] -2.395864 2.793284
    [3,] -3.881068 2.164721
    [4,] -3.420959 3.259126
    [5,] -3.666715 3.576445
    [6,] -2.934782 2.833069

Quick plot of x to see the code:

``` r
plot(x)
```

![](Class07_files/figure-commonmark/unnamed-chunk-5-1.png)

The plot above can clearly be seen as two groups.

Use the ‘kmeans()’ function setting k to 2 and nstart = 20. nstart
specifies how many iterations.

``` r
km <- kmeans(x, centers = 2, nstart = 20)

km
```

    K-means clustering with 2 clusters of sizes 30, 30

    Cluster means:
              x         y
    1 -3.322110  3.063005
    2  3.063005 -3.322110

    Clustering vector:
     [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2
    [39] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2

    Within cluster sum of squares by cluster:
    [1] 52.21998 52.21998
     (between_SS / total_SS =  92.1 %)

    Available components:

    [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss"
    [6] "betweenss"    "size"         "iter"         "ifault"      

> Q. How many points are in each cluster?

(check the help page to see which component will help you)

``` r
km$size
```

    [1] 30 30

> What ‘component’ of your reulst object details: - cluster
> assignment/membership - cluster center

``` r
km$cluster
```

     [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2
    [39] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2

``` r
km$centers
```

              x         y
    1 -3.322110  3.063005
    2  3.063005 -3.322110

> Q. Plot x colored by the kmeans cluster assignment and add cluster
> centers as blue points.

You can color by ‘col = “blue”’ or can color by ‘col = 1’ because colors
are numbered.

``` r
plot(x, col= c("red", "blue"))
```

![](Class07_files/figure-commonmark/unnamed-chunk-10-1.png)

This input alternates the color by each data point and is not what is
desired.

Instead, use the assignments of each variable to each cluster to code
the color:

``` r
plot(x, col = km$cluster)
```

![](Class07_files/figure-commonmark/unnamed-chunk-11-1.png)

Then add cluster centers as blue points: (pch and cex are not necessary,
just make the points bigger)

``` r
plot(x, col = km$cluster)

points(km$centers, col = "blue", pch =15, cex=2)
```

![](Class07_files/figure-commonmark/unnamed-chunk-12-1.png)

Play with kmeans and ask for different number of clusters:

R will provide you with the number of clusters you ask for, even if
there are not that amount of clusters.

``` r
km2 <- kmeans(x, centers = 4, nstart = 20)

plot(x, col = km2$cluster)

points(km2$centers, col = "blue", pch =15, cex=2)
```

![](Class07_files/figure-commonmark/unnamed-chunk-13-1.png)

# Hierarchical Clustering:

This is another very useful and widely employed clustering method which
has the advantage over kmeans in that it can help reveal something of
the true grouping in your data.

The ‘hclust()’ function wants a distance matrix as input. We can get
this from the ‘dist()’ function.

``` r
d <- dist(x)
hc <- hclust(d)
hc
```


    Call:
    hclust(d = d)

    Cluster method   : complete 
    Distance         : euclidean 
    Number of objects: 60 

There is a plot method for hclust results.

``` r
plot(hc)
#abline() adds a solid line at specified height
abline(h=10, col="red")
```

![](Class07_files/figure-commonmark/unnamed-chunk-15-1.png)

To get my cluster membership vector, I need to “cut” my tree to yield
sub-trees or branches with all the members of a given cluster residing
on the same cut branch. The function to do this is called ‘cutree()’
(note this is spelled with one t).

For cutree(), you can input the height you would like to cut the
dendogram (h=10) or the number of clusters you would like (k=2).

It is often helpful to use the ‘k=’ argument rather than the ‘h=’
because it can be hard to distinguish the height you want for a specific
number of clusters.

``` r
# save grps to plot results
grps <- cutree(hc, h =10)
grps
```

     [1] 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2
    [39] 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2

``` r
plot(x, col = grps)
```

![](Class07_files/figure-commonmark/unnamed-chunk-17-1.png)

# Principal Component Analysis (PCA)

Objective is to take complex datasets and make them easier to visualize
and understand.

The base R function for PCA is called ‘prcomp()’.

# PCA of UK Food

``` r
url <- "https://tinyurl.com/UK-foods"

x <- read.csv(url)

head(x)
```

                   X England Wales Scotland N.Ireland
    1         Cheese     105   103      103        66
    2  Carcass_meat      245   227      242       267
    3    Other_meat      685   803      750       586
    4           Fish     147   160      122        93
    5 Fats_and_oils      193   235      184       209
    6         Sugars     156   175      147       139

> Q1. How many rows and columns are in your new data frame named x? What
> R functions could you use to answer this questions?

``` r
nrow(x)
```

    [1] 17

``` r
ncol(x)
```

    [1] 5

There are 17 rows and 5 columns in this dataset. (also could have used
‘dim()’ function)

Preview the first 6 columns to check for issues with importing:

``` r
head(x)
```

                   X England Wales Scotland N.Ireland
    1         Cheese     105   103      103        66
    2  Carcass_meat      245   227      242       267
    3    Other_meat      685   803      750       586
    4           Fish     147   160      122        93
    5 Fats_and_oils      193   235      184       209
    6         Sugars     156   175      147       139

We were expecting 4 columns (one for each country), not 5! Now we have
to change the rownames from classification as a column:

``` r
rownames(x) <- x[,1]

x <- x[,-1]

head(x)
```

                   England Wales Scotland N.Ireland
    Cheese             105   103      103        66
    Carcass_meat       245   227      242       267
    Other_meat         685   803      750       586
    Fish               147   160      122        93
    Fats_and_oils      193   235      184       209
    Sugars             156   175      147       139

``` r
dim(x)
```

    [1] 17  4

It is now fixed!There are only 4 columns now. (could also have written:
‘x \<- read.csv(url, row.names = 1)’)

> Q2. Which approach to solving the ‘row-names problem’ mentioned above
> do you prefer and why? Is one approach more robust than another under
> certain circumstances?

I prefer the ‘read.csv’ solution as it requires less code and leaves
less room for error. The first solution could remove more rows than
intended. If used multiple times, we can lose data.

``` r
barplot(as.matrix(x), beside = T, col = rainbow(nrow(x)))
```

![](Class07_files/figure-commonmark/unnamed-chunk-23-1.png)

> Q3: Changing what optional argument in the above barplot() function
> results in the following plot?

We could change ‘beside’. to ‘FALSE’ to get stacked bars instead of
juxtaposed bars.

``` r
barplot(as.matrix(x), beside = F, col = rainbow(nrow(x)))
```

![](Class07_files/figure-commonmark/unnamed-chunk-24-1.png)

> Q5: Generating all pairwise plots may help somewhat. Can you make
> sense of the following code and resulting figure? What does it mean if
> a given point lies on the diagonal for a given plot?

``` r
pairs(x, col=rainbow(10), pch = 16)
```

![](Class07_files/figure-commonmark/unnamed-chunk-25-1.png)

The code above produces a matrix of scatterplots. ‘col’ and ‘pch’ are
just cosmetic compenents. But the diagonal (which lists each of the
countries) specifies the two countries being compared in each plot in
the matrix.

When a given point (type of food) lies on the diagonal, the two
countries consume the same amount of that given food. More variance from
the diagonal means that the two countries consume different amounts of
the types of food. One can see that Northern Ireland has more variance
in their consumption than the other countries.

> Q6. What is the main differences between N. Ireland and the other
> countries of the UK in terms of this data-set?

Northern Ireland consumes more of the “dark blue” datapt, less of the
“orange” datapt, and less of the “light blue” data pt. They consume more
soft drinks, and less fresh fruit and alcohol.

Note: ‘t’ is transverse of x (countries go from columns to rows)

``` r
pca <- prcomp( t(x))
summary(pca)
```

    Importance of components:
                                PC1      PC2      PC3       PC4
    Standard deviation     324.1502 212.7478 73.87622 4.189e-14
    Proportion of Variance   0.6744   0.2905  0.03503 0.000e+00
    Cumulative Proportion    0.6744   0.9650  1.00000 1.000e+00

Note: ‘proportion of variance’ is variance captured with that particular
PCA, ‘cumulative proportion’ is the variance captured with each PCA up
to that point. For example, PCA1 and PCA2 capture 96% of the variation.

A “PCA plot” (a.k.a. “Score Plot”, PC1vsPC2 plot, etc)

``` r
pca$x
```

                     PC1         PC2         PC3           PC4
    England   -144.99315    2.532999 -105.768945  2.842865e-14
    Wales     -240.52915  224.646925   56.475555  7.804382e-13
    Scotland   -91.86934 -286.081786   44.415495 -9.614462e-13
    N.Ireland  477.39164   58.901862    4.877895  1.448078e-13

> Q7. Complete the code below to generate a plot of PC1 vs PC2. The
> second line adds text labels over the data points.

> Q8. Customize your plot so that the colors of the country names match
> the colors in our UK and Ireland map and table at start of this
> document.

(answered Q7 + Q8 in same plot)

``` r
plot(pca$x[,1], pca$x[,2], 
     col = c( "orange", "red", "blue", "green"), pch = 15, xlab = "PC1", ylab = "PC2", xlim = c(-270,500))

text(pca$x[,1], pca$x[,2], colnames(x))
```

![](Class07_files/figure-commonmark/unnamed-chunk-28-1.png)

From this plot, we can see that Ireland is farther from the other
countries along the PC1 axis, which means there is more variance.

Loadings plot for PC1:

``` r
par(mar = c(10, 3, 0.35, 0))
barplot( pca$rotation[,1], las =2 )
```

![](Class07_files/figure-commonmark/unnamed-chunk-29-1.png)

> Q9: Generate a similar ‘loadings plot’ for PC2. What two food groups
> feature prominantely and what does PC2 maninly tell us about?

``` r
par(mar = c(10, 3, 0.35, 0))
barplot( pca$rotation[,2], las =2 )
```

![](Class07_files/figure-commonmark/unnamed-chunk-30-1.png)

Soft drinks and fresh potatoes feature most prominently in the loadings
plot for PC2.
