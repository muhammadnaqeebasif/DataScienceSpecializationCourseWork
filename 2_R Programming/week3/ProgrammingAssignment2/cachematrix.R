## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
##This function make a cache of matrix as well as its inverse
makeCacheMatrix <- function(x = matrix()) {
    inv <- NULL
    set <- function(y) {
        x <<- y
        inv <<-NULL
    }
    get <- function() x
    setinverse <- function(inverse) inv <<- inverse
    getinverse <- function() inv
    list(set=set,get=get,setinverse=setinverse,
         getinverse=getinverse)
}


## Write a short comment describing this function
##This function finds the inverse and then make a cache of 
##inverse by calling setinverse function of x object
cacheSolve <- function(x, ...) {
    inv <- x$getinverse()
    if(!is.null(inv)){
        message("getting cached data")
        return(inv)
    }
    mat <- x$get()
    dim_mat = dim(mat)
    if(dim_mat[1]!=dim_mat[2] || det(mat)==0){
        print("Inverse of the matrix does not exist")
    }
    else{
        inv <- solve(mat, ...)
        x$setinverse(inv)
        inv
    }
}
