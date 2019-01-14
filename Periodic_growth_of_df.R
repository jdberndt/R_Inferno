# adpated from R Inferno https://www.burns-stat.com/documents/books/the-r-inferno/
#
# This script is an example of one way to overcome the issue of fragmented memory caused by 'growing objects'. It is best to define the size (length, nrow, etc.) of an object (e.g. numeric vector or data, frame) prior to adding to memory and then iteratively fill the container. However, if you are unable to estimate the size of the necessary container and/or you cannot predict the size of the batches of things you are adding to the container, then you can grow the container periodically. This limits the frequency of rewriting/moving the appended object to a different place in memory on each iteration and thus reduces fragmentation.
#
#
#
n <- as.numeric(10)
current.N <- 10 * n
my.df <- data.frame(a = character(current.N),
                    b = numeric(current.N), 
                    stringsAsFactors = FALSE)
count <- 0
set.seed(58008)
for (i in 1:n){
        this.N <- rpois(1, 10)

        if (count + this.N > current.N) {
                old.df <- my.df
                current.N <- round(1.5 * (current.N + this.N))
                my.df <- data.frame(a = character(current.N),
                            b = numeric(current.N),
                            stringsAsFactors = F)
                my.df[1:count, ] <- old.df[1:count,]
                print(my.df)
        }
my.df[count + 1:this.N, ] <- data.frame(a = sample(letters,
                                                   this.N, replace = TRUE),
                                        b = runif(this.N))
count <- count + this.N
}
my.df <- my.df[1:count, ] #this operation trims the zero rows from the bottom
my.df
