#pregunta 1----

#1a----
#install.packages("rgl")
x<-seq(0,3,length=30)
y<-seq(0,2,length=30)
f<-function(x,y) x*y^2*sqrt(x^2+y^3)
library(rgl)
z<-outer(x, y,f)
library(rgl)
ecuacion <- expression(z == x*y^2*sqrt(x^2+y^3))
persp(x,y,z,theta = 30, phi = 30, col = "orange",sub = ecuacion, main = "grafico",
      col.main="blue")
        

#1b----
#esta en la tablet

#1c----
#crando funcion
n <- 100000
k <- runif(n,0,1)
j <- runif(n,0,1)
m <- NULL

for (i in 1:n){
  m[i] <-72*(k[i])^(2)*j[i]*sqrt((3*j[i])^2+(2*k[i])^3) 
}

mean(m)

#install.packages("pracma")
library(pracma)
integral2(f,0,3,0,2,sector = FALSE)

#con 10^2
n <- 10^2
k <- runif(n,0,1)
j <- runif(n,0,1)
m <- NULL

for (i in 1:n){
  m[i] <-72*(k[i])^(2)*j[i]*sqrt((3*j[i])^2+(2*k[i])^3) 
}

mean(m)

#con 10^3
n <- 10^3
k <- runif(n,0,1)
j <- runif(n,0,1)
m <- NULL

for (i in 1:n){
  m[i] <-72*(k[i])^(2)*j[i]*sqrt((3*j[i])^2+(2*k[i])^3) 
}

mean(m)

#con 10^4
n <- 10^4
k <- runif(n,0,1)
j <- runif(n,0,1)
m <- NULL

for (i in 1:n){
  m[i] <-72*(k[i])^(2)*j[i]*sqrt((3*j[i])^2+(2*k[i])^3) 
}

mean(m)


#a medida que se se usan mas variables uniformes mejora la aproximación




#######################################################################################
#2----

##########################################################################################
#3----

n <- 10^4
x <- c()
b <- 5
a <- 0
u <- runif(n,0,1)
for (i in 1:n){
  if (u[i]<0.5){
    x <- c(x,2*a+(b-a)*sqrt(2*u[i]))
  }else{
    x <- c(x,2*b+(a-b)*sqrt(2*(1-u[i])))
  }
}


hist(x,freq=FALSE)
fe1 <- function(x){
  x <- rep(0,n)
  return(0)
}

fe2 <- function(x){
  return((x-2*a)/(b-a)^2)}

fe3 <- function(x){
  return((2*b-x)/(b-a)^2)
}


curve(fe2(x),add = TRUE)
curve(fe3(x),add = TRUE)







