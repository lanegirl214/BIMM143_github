add <- function(x, y=1) {x + y}

add(x=4)

add(x=4, y=10)

add(4,20)

add(c(1,2,5,10), y=10)

add(c(1,2,5,10), 10)

add(c(1,2,5,10), 10,20)

add(c(1,2,5,10), y="string")




# Our 2nd function rescale()

rescale <- function(x) {
  rng <- range(x)
  (x - rng[1]) / (rng[2] - rng[1])
}

#Test on a simple example
rescale(1:10)

rescale( c(1,4,10,20))

#imagine NA is a missing data value
rescale( c(1, NA, 4, 10, 20))

#go back and revise function

range(c(1, NA, 4, 10, 20))

# the range function is where the NA's are coming from
#?range to learn more about function
#find that na.rm = FALSE, so change to true 


range(c(1, NA, 4, 10, 20), na.rm=TRUE)

# the change worked! So revise the function!
#change the name, and revise na.rm in range function
rescale01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

#Now retest
rescale01( c(1, NA, 4, 10, 20))

rescale01( c(1, 4, "more"))
# the character gives and error message, as expected

#If you want to save the rescale function again, without this script.
